import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  String? selectedWeightRange;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final _descriptionController = TextEditingController();

  final List<String> categories = [
    'E-Waste',
    'Plastic Waste',
    'Bio-Medical Waste',
    'Other',
  ];

  final List<String> weightRanges = [
    'Under 5 kg',
    '5-20 kg',
    '20-50 kg',
    '50-100 kg',
    'Above 100 kg',
  ];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      // Save request logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pickup request scheduled successfully!'),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Pickup Request')),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Schedule a Pickup',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Fill in the details for waste collection',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 24),

              // Waste Category
              Text(
                'Waste Category *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                hint: Text('Select waste type'),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedCategory = value),
                validator: (value) =>
                    value == null ? 'Please select category' : null,
              ),
              SizedBox(height: 16),

              // Weight Range
              Text(
                'Estimated Weight *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: selectedWeightRange,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.scale),
                ),
                hint: Text('Select weight range'),
                items: weightRanges.map((range) {
                  return DropdownMenuItem(value: range, child: Text(range));
                }).toList(),
                onChanged: (value) =>
                    setState(() => selectedWeightRange = value),
                validator: (value) =>
                    value == null ? 'Please select weight' : null,
              ),
              SizedBox(height: 16),

              // Date Selection
              Text(
                'Pickup Date *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey[600]),
                      SizedBox(width: 12),
                      Text(
                        selectedDate == null
                            ? 'Select date'
                            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Time Selection
              Text(
                'Pickup Time *',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: _selectTime,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.grey[600]),
                      SizedBox(width: 12),
                      Text(
                        selectedTime == null
                            ? 'Select time'
                            : selectedTime!.format(context),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Description
              Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Describe the waste items (optional)',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                  ),
                  child: Text(
                    'Schedule Pickup',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
