import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory, selectedWeightRange;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();

  final List<String> categories = ['E-Waste', 'Plastic Waste', 'Other'];
  final List<String> weightRanges = [
    'Under 5 kg',
    '5-20 kg',
    '20-50 kg',
    '50-100 kg',
    'Above 100 kg',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserAddress();
  }

  Future<void> _loadUserAddress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _addressController.text = prefs.getString('user_address') ?? '';
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryGreen,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryGreen,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      final prefs = await SharedPreferences.getInstance();
      final requests = prefs.getStringList('pickup_requests') ?? [];
      requests.add(
        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}|'
        '${selectedCategory}|${selectedWeightRange}|'
        '${selectedTime!.format(context)}',
      );
      await prefs.setStringList('pickup_requests', requests);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Expanded(child: Text('Pickup request scheduled successfully!')),
              ],
            ),
            backgroundColor: AppTheme.primaryGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Text('Please fill all required fields')),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule Pickup',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          _RippleBg(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _glassHeader(),
                  const SizedBox(height: 28),
                  _pillDropdown(
                    icon: Icons.category,
                    label: 'Waste Category *',
                    hint: 'Select waste type',
                    value: selectedCategory,
                    items: categories,
                    onChanged: (v) => setState(() => selectedCategory = v),
                    validator: (v) => v == null ? 'Category required' : null,
                  ),
                  const SizedBox(height: 19),
                  _pillDropdown(
                    icon: Icons.scale,
                    label: 'Estimated Weight *',
                    hint: 'Select weight range',
                    value: selectedWeightRange,
                    items: weightRanges,
                    onChanged: (v) => setState(() => selectedWeightRange = v),
                    validator: (v) => v == null ? 'Weight required' : null,
                  ),
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Expanded(
                        child: _glassDateTile(
                          icon: Icons.calendar_today,
                          label: "Pickup Date *",
                          value: selectedDate == null
                              ? "Select"
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          onPressed: _selectDate,
                          highlight: selectedDate != null,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: _glassDateTile(
                          icon: Icons.access_time,
                          label: "Pickup Time *",
                          value: selectedTime == null
                              ? "Select"
                              : selectedTime!.format(context),
                          onPressed: _selectTime,
                          highlight: selectedTime != null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _pillTextField(
                    icon: Icons.location_on,
                    label: 'Pickup Address *',
                    hint: 'Enter address',
                    controller: _addressController,
                    validator: (v) =>
                        v?.isEmpty ?? true ? 'Address required' : null,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  _pillTextField(
                    icon: Icons.description,
                    label: 'Additional Notes',
                    hint: 'Describe your waste (optional)',
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 28),
                  _mainCTAButton(),
                  const SizedBox(height: 17),
                  _buildInfoCard(),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassHeader() => Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(26),
      color: Colors.white.withOpacity(0.66),
      boxShadow: [
        BoxShadow(
          color: AppTheme.primaryGreen.withOpacity(.07),
          blurRadius: 9,
          offset: const Offset(0, 7),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Schedule a Pickup',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 6),
              Text(
                'Fill in the details for waste collection',
                style: TextStyle(
                  fontSize: 14.3,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _pillDropdown({
    required IconData icon,
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.8),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            prefixIcon: Container(
              margin: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(.09),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
            ),
            filled: true,
            fillColor: Colors.grey[40],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
          ),
          hint: Text(hint),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  Widget _glassDateTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onPressed,
    required bool highlight,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(19),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color: Colors.white.withOpacity(.77),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: highlight ? AppTheme.primaryGreen : Colors.grey[300]!,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(.11),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.4,
                      color: highlight ? Colors.black : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillTextField({
    required IconData icon,
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
            prefixIcon: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 19),
            ),
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[30],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 11,
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainCTAButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: _submitRequest,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2.5,
        ),
        icon: const Icon(Icons.bolt_rounded),
        label: const Text(
          'Schedule Pickup',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.lightBlue[100]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700]),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              'Our team will contact you 30 minutes before pickup. Please keep your waste ready for collection.',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 14.4,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

// Decorative ripple bg
class _RippleBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _BGCircle(
            color: AppTheme.primaryGreen.withOpacity(0.11),
            left: -60,
            top: -8,
            radius: 120,
          ),
          _BGCircle(
            color: Colors.green.withOpacity(0.07),
            left: 170,
            top: -18,
            radius: 80,
          ),
          _BGCircle(
            color: Colors.greenAccent.withOpacity(0.11),
            left: 0,
            top: 214,
            radius: 105,
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
