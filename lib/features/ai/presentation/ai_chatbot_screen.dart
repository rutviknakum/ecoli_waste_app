import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../core/themes/app_theme.dart';

class AIChatbotScreen extends StatefulWidget {
  const AIChatbotScreen({Key? key}) : super(key: key);

  @override
  State<AIChatbotScreen> createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends State<AIChatbotScreen> {
  static const apiKey = 'YOUR_GEMINI_API_KEY'; // Replace with your key
  final _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  late GenerativeModel _model;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    _addBotMessage(
      'Hello! I can help you identify waste categories and answer questions about waste management. How can I assist you?',
    );
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: false));
    });
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final userMessage = _messageController.text;
    _addUserMessage(userMessage);
    _messageController.clear();

    setState(() => _isLoading = true);

    try {
      final prompt = '''You are an AI assistant for a waste management company. 
      Help users identify waste categories (E-Waste, Plastic, Bio-Medical) and 
      confirm if their waste fits these categories. User query: $userMessage''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      _addBotMessage(
        response.text ?? 'Sorry, I could not process your request.',
      );
    } catch (e) {
      _addBotMessage('Sorry, an error occurred. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Waste Assistant'),
        backgroundColor: AppTheme.primaryGreen,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),

          // Loading indicator
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(color: AppTheme.primaryGreen),
            ),

          // Input area
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask about waste categories...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppTheme.primaryGreen,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser ? AppTheme.primaryGreen : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
