import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  List<Map<String, dynamic>> pickupHistory = [];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadPickupHistory();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('user_name') ?? '';
      _emailController.text = prefs.getString('user_email') ?? '';
      _phoneController.text = prefs.getString('user_phone') ?? '';
      _addressController.text = prefs.getString('user_address') ?? '';
    });
  }

  Future<void> _saveUserProfile() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _nameController.text);
      await prefs.setString('user_email', _emailController.text);
      await prefs.setString('user_phone', _phoneController.text);
      await prefs.setString('user_address', _addressController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Profile saved successfully'),
              ],
            ),
            backgroundColor: AppTheme.primaryGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  Future<void> _loadPickupHistory() async {
    await SharedPreferences.getInstance();
    setState(() {
      pickupHistory = [
        {
          'date': '25 Oct 2025',
          'type': 'E-Waste',
          'weight': '15 kg',
          'status': 'Completed',
        },
        {
          'date': '20 Oct 2025',
          'type': 'Plastic Waste',
          'weight': '8 kg',
          'status': 'Completed',
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          _ProfileBgRipples(),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                _buildUniqueProfileHeader(isDark),
                const SizedBox(height: 33),
                _buildProfileForm(isDark),
                const SizedBox(height: 28),
                _buildPickupHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========== UNIQUE PROFILE HEADER ==========
  Widget _buildUniqueProfileHeader(bool isDark) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white.withOpacity(isDark ? 0.10 : 0.30),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGreen.withOpacity(.13),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: AppTheme.primaryGreen.withOpacity(.14),
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(.11),
                        blurRadius: 7,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: AppTheme.primaryGreen,
                    child: Icon(Icons.person, size: 51, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _nameController.text.isEmpty
                      ? 'User Name'
                      : _nameController.text,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _emailController.text.isEmpty
                      ? 'your@email.com'
                      : _emailController.text,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[200] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.verified, color: Colors.green, size: 17),
                      SizedBox(width: 4),
                      Text(
                        "EcoChip Member",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== MODERN PROFILE FORM ==========
  Widget _buildProfileForm(bool isDark) {
    // Accent backgrounds for prefixed icons
    Color iconBg = AppTheme.primaryGreen.withOpacity(.11);
    return Form(
      key: _formKey,
      child: Card(
        elevation: isDark ? 2 : 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        color: isDark ? Colors.grey[900] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Information",
                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 21),
              _pillField(
                controller: _nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: Icons.person,
                iconBg: iconBg,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Name is required' : null,
              ),
              const SizedBox(height: 18),
              _pillField(
                controller: _emailController,
                label: 'Email ID',
                hint: 'Email address',
                icon: Icons.email,
                iconBg: iconBg,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Email is required';
                  if (!value!.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: 18),
              _pillField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'Your phone number',
                icon: Icons.phone,
                iconBg: iconBg,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Phone is required';
                  if (value!.length < 10) return 'Invalid phone number';
                  return null;
                },
              ),
              const SizedBox(height: 18),
              _pillField(
                controller: _addressController,
                label: 'Address',
                hint: 'Your address',
                icon: Icons.location_on,
                iconBg: iconBg,
                maxLines: 3,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Address is required' : null,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _saveUserProfile,
                  icon: const Icon(Icons.save),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2.5,
                  ),
                  label: const Text(
                    'Save Profile',
                    style: TextStyle(
                      fontSize: 16.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pillField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    Color? iconBg,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: iconBg ?? Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: AppTheme.primaryGreen),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.5,
          horizontal: 13,
        ),
      ),
    );
  }

  // ========== UNIQUE PICKUP HISTORY ==========
  Widget _buildPickupHistory() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 30, top: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pickup Request History',
              style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            pickupHistory.isEmpty
                ? _buildEmptyHistory()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pickupHistory.length,
                    itemBuilder: (context, index) {
                      final item = pickupHistory[index];
                      return _buildHistoryCard(item);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.history, size: 54, color: Colors.grey[350]),
          const SizedBox(height: 14),
          Text(
            'No pickup history available',
            style: TextStyle(color: Colors.grey[600], fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 13),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(13),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryGreen.withOpacity(0.10),
          child: Icon(Icons.recycling, color: AppTheme.primaryGreen, size: 24),
        ),
        title: Text(
          item['type'],
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '${item['date']} • ${item['weight']}',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.6),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: item['status'] == 'Completed' ? Colors.green : Colors.orange,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            item['status'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

// Decorative background ripples
class _ProfileBgRipples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _CircleProfile(
            color: AppTheme.primaryGreen.withOpacity(0.10),
            left: -70,
            top: -10,
            radius: 120,
          ),
          _CircleProfile(
            color: Colors.green.withOpacity(0.09),
            left: 190,
            top: -25,
            radius: 75,
          ),
          _CircleProfile(
            color: Colors.greenAccent.withOpacity(0.13),
            left: 0,
            top: 200,
            radius: 110,
          ),
        ],
      ),
    );
  }
}

class _CircleProfile extends StatelessWidget {
  final Color color;
  final double left, top, radius;
  const _CircleProfile({
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
