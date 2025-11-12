import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../core/themes/app_theme.dart';

class AIChatbotScreen extends StatefulWidget {
  const AIChatbotScreen({Key? key}) : super(key: key);

  @override
  State<AIChatbotScreen> createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends State<AIChatbotScreen>
    with SingleTickerProviderStateMixin {
  static const String apiKey = 'AIzaSyBSfUohhZWj7svrxBfC-PBxXO_z8BreyiI';
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final _focusNode = FocusNode();
  late GenerativeModel _model;
  late AnimationController _animationController;
  bool _isLoading = false;
  bool _showSuggestions = true;

  final List<QuickSuggestion> _suggestions = [
    QuickSuggestion(icon: '💻', text: 'What is E-Waste?'),
    QuickSuggestion(icon: '♻️', text: 'How to recycle plastic bottles?'),
    QuickSuggestion(icon: '🔋', text: 'Can I recycle batteries?'),
    QuickSuggestion(icon: '📱', text: 'How to dispose old phones?'),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _addBotMessage(
      '👋 Hi! I\'m EcoChip\'s AI Assistant.\n\n'
      'I\'m here to help you with:\n'
      '• E-Waste identification & recycling\n'
      '• Plastic waste management tips\n'
      '• Scheduling pickups\n'
      '• Environmental best practices\n\n'
      'How can I assist you today?',
    );
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: false, timestamp: DateTime.now()),
      );
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage({String? predefinedMessage}) async {
    final messageText = predefinedMessage ?? _messageController.text.trim();
    if (messageText.isEmpty) return;
    setState(() {
      _showSuggestions = false;
    });

    _addUserMessage(messageText);
    if (predefinedMessage == null) {
      _messageController.clear();
    }

    setState(() => _isLoading = true);
    _animationController.repeat();

    try {
      final prompt =
          '''You are EcoChip's friendly AI assistant. You're an expert in waste management, specializing in E-Waste and Plastic recycling.

Guidelines:
- Be warm, helpful, and conversational
- Give clear, actionable advice (2-4 sentences max)
- Use simple language, avoid jargon
- If asked about services, mention: E-Waste collection, Plastic recycling, and free pickup scheduling
- If the question is outside waste management, politely redirect to your expertise
- Use emojis sparingly for friendliness (♻️ 🌍 💚)

User: $messageText

Respond in a helpful, conversational tone:''';

      final content = [Content.text(prompt)];
      final response = await _model
          .generateContent(content)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw TimeoutException('Timeout'),
          );

      if (response.text != null && response.text!.isNotEmpty) {
        _addBotMessage(response.text!);
      } else {
        _addBotMessage(
          '🤔 I\'m having trouble understanding. Could you rephrase that?',
        );
      }
    } on TimeoutException {
      _addBotMessage(
        '⏱️ Taking longer than expected...\n\n'
        'Your internet might be slow. Try again?',
      );
    } catch (e) {
      _addBotMessage(
        '😅 Oops! Something went wrong.\n\n'
        'Please check your connection and try again.',
      );
    } finally {
      setState(() => _isLoading = false);
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF11181D) : Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: GlassAppBar(),
      ),
      body: Stack(
        children: [
          _ChatBgRipples(),
          Column(
            children: [
              Expanded(
                child: _messages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return _buildMessageBubble(_messages[index]);
                        },
                      ),
              ),
              if (_isLoading) _buildTypingIndicator(),
              if (_showSuggestions && _messages.length <= 1)
                _buildQuickSuggestions(),
              _buildInputArea(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryGreen.withOpacity(0.1),
                  AppTheme.primaryGreen.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.eco, size: 80, color: AppTheme.primaryGreen),
          ),
          const SizedBox(height: 24),
          const Text(
            'Welcome to EcoChip AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Your intelligent assistant for waste management and recycling guidance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final bool isUser = message.isUser;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isUser) ...[
          Container(
            margin: const EdgeInsets.only(right: 5, bottom: 2, top: 7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppTheme.primaryGreen, Colors.greenAccent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
          ),
        ],
        Flexible(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(bottom: 16, top: 7),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
            decoration: BoxDecoration(
              gradient: isUser
                  ? LinearGradient(
                      colors: [
                        AppTheme.primaryGreen,
                        AppTheme.primaryGreen.withOpacity(0.8),
                      ],
                    )
                  : LinearGradient(colors: [Colors.white, Colors.grey[100]!]),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25),
                topRight: const Radius.circular(25),
                bottomLeft: Radius.circular(isUser ? 22 : 5),
                bottomRight: Radius.circular(isUser ? 5 : 22),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 11,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 15.2,
                height: 1.55,
              ),
            ),
          ),
        ),
        if (isUser) ...[
          Container(
            margin: const EdgeInsets.only(left: 5, bottom: 2, top: 7),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(7),
              child: Icon(Icons.person, size: 20, color: Colors.black54),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(1),
                const SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double delay = index * 0.2;
        final double value = (_animationController.value - delay).clamp(
          0.0,
          1.0,
        );
        final double scale = 1.0 + (value * 0.5);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickSuggestions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick questions',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 9,
            runSpacing: 9,
            children: _suggestions.map((s) {
              return InkWell(
                onTap: () => _sendMessage(predefinedMessage: s.text),
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(s.icon, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 7),
                      Text(
                        s.text,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Ask me anything...',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen,
                    AppTheme.primaryGreen.withOpacity(0.8),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: _isLoading ? null : () => _sendMessage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

// Glass/Frosted AppBar implementation
class GlassAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.43),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 14,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(19, 24, 19, 17),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryGreen, Colors.greenAccent],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(.11),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.smart_toy,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EcoChip AI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.5,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.circle, size: 9, color: Color(0xFF34C759)),
                          SizedBox(width: 6),
                          Text(
                            'Online',
                            style: TextStyle(
                              fontSize: 12.3,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.black87),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('About EcoChip AI'),
                      content: const Text(
                        'A next-gen Eco assistant powered by Google Gemini. Ask anything about E-Waste, recycling, scheduling and eco tips!',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                  tooltip: 'About',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Decorative ripple background for chat
class _ChatBgRipples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _BGCircle(
            color: AppTheme.primaryGreen.withOpacity(0.13),
            left: -80,
            top: -16,
            radius: 140,
          ),
          _BGCircle(
            color: Colors.greenAccent.withOpacity(0.08),
            left: 120,
            top: 400,
            radius: 110,
          ),
          _BGCircle(
            color: Colors.lightGreenAccent.withOpacity(0.09),
            left: 210,
            top: -20,
            radius: 88,
          ),
        ],
      ),
    );
  }
}

class _BGCircle extends StatelessWidget {
  final Color color;
  final double left, top, radius;
  const _BGCircle({
    required this.color,
    required this.left,
    required this.top,
    required this.radius,
  });
  @override
  Widget build(BuildContext context) => Positioned(
    left: left,
    top: top,
    child: Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    ),
  );
}

// MODELS
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class QuickSuggestion {
  final String icon;
  final String text;
  QuickSuggestion({required this.icon, required this.text});
}
