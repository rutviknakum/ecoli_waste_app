import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';
import '../../../app/router.dart';

class PlasticScreen extends StatefulWidget {
  const PlasticScreen({Key? key}) : super(key: key);

  @override
  State<PlasticScreen> createState() => _PlasticScreenState();
}

class _PlasticScreenState extends State<PlasticScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 820),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const CustomDrawer(),
      floatingActionButton: _buildFAB(context),
      body: Stack(
        children: [
          _BgAnimatedRipples(color: AppTheme.secondaryBlue),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(context),
                  _buildQuickStats(),
                  _buildInfoSection(),
                  _buildAcceptedPlastics(),
                  _buildTypesSection(),
                  _buildImpactSection(),
                  _buildRecyclingTips(),
                  _buildFAQSection(),
                  //  _buildCTASection(context),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Plastic Waste Management',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      // backgroundColor: AppTheme.secondaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          color: Colors.black,
          onPressed: () => _showInfoDialog(),
          tooltip: 'More Info',
        ),
      ],
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, AppRouter.schedule),
      backgroundColor: AppTheme.secondaryBlue,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.calendar_today, size: 21),
      label: const Text(
        'Schedule Pickup',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      elevation: 8,
      heroTag: 'plastic_fab',
    );
  }

  // HERO (with glass/animated ripples)
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.secondaryBlue,
            AppTheme.secondaryBlue.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        children: [
          _HeroCircle(top: -60, right: -60, size: 220, opacity: 0.10),
          _HeroCircle(bottom: -40, left: -40, size: 180, opacity: 0.08),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(21),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.29),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.recycling,
                    size: 74,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Plastic Waste\nManagement',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.7,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 10),
                _PillGlass(
                  text: '500 Mt/Month Capacity',
                  icon: Icons.flash_on,
                  color: Colors.white,
                  iconColor: AppTheme.secondaryBlue,
                ),
                const SizedBox(height: 10),
                const Text(
                  'EPR Compliance & Extended Producer Responsibility',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final stats = [
      {'value': '20+', 'label': 'Years Experience', 'icon': Icons.work_history},
      {'value': '50K+', 'label': 'Tons Recycled', 'icon': Icons.recycling},
      {'value': '100%', 'label': 'Eco-Friendly', 'icon': Icons.eco},
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 10),
      child: Row(
        children: stats.map((s) {
          return Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.3, end: 1),
              duration: Duration(milliseconds: 1200 + stats.indexOf(s) * 230),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: _buildStatCard(
                    s['value'] as String,
                    s['label'] as String,
                    s['icon'] as IconData,
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondaryBlue.withOpacity(0.13),
            blurRadius: 9,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppTheme.secondaryBlue.withOpacity(0.12)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.secondaryBlue, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue[50]!, Colors.white]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryBlue.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: AppTheme.secondaryBlue,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'About Plastic Waste',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Plastic waste means all plastic products that end up as waste or pollution. We collect, sort, and recycle every kind of plastic to reduce environmental impact and promote a circular economy.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[800],
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptedPlastics() {
    final items = [
      {'icon': Icons.local_drink, 'name': 'PET Bottles', 'color': Colors.blue},
      {
        'icon': Icons.shopping_bag,
        'name': 'Plastic Bags',
        'color': Colors.green,
      },
      {'icon': Icons.dashboard, 'name': 'Containers', 'color': Colors.orange},
      {'icon': Icons.kitchen, 'name': 'Food Packaging', 'color': Colors.purple},
      {'icon': Icons.toys, 'name': 'Plastic Products', 'color': Colors.red},
      {
        'icon': Icons.business_center,
        'name': 'Industrial Plastic',
        'color': Colors.teal,
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What We Accept',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'We recycle all types of plastic waste',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.33,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _AcceptedItemCard(
                icon: items[index]['icon'] as IconData,
                name: items[index]['name'] as String,
                color: items[index]['color'] as Color,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _AcceptedItemCard({
    required IconData icon,
    required String name,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(.09),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.11),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: color.withOpacity(.13),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 26, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ... The rest of your methods remain unchanged (Types, Impact, Recycling Tips, FAQ, CTA, _showInfoDialog, etc., as in your last code)
  Widget _buildTypesSection() {
    final types = const [
      'PET (1)',
      'HDPE (2)',
      'PVC (3)',
      'LDPE (4)',
      'PP (5)',
      'PS (6)',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Plastic Types',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: types
                .map(
                  (t) => Chip(
                    label: Text(t),
                    backgroundColor: AppTheme.secondaryBlue.withOpacity(0.08),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Environmental Impact',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Recycling plastic reduces landfill waste and pollution, conserves resources, and lowers greenhouse gas emissions.',
          ),
        ],
      ),
    );
  }

  Widget _buildRecyclingTips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Recycling Tips',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Rinse containers, remove excess food, separate by type when possible, and collapse bottles to save space.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'FAQ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Q: Do you accept dirty plastics?\nA: Lightly soiled items are accepted; heavily contaminated items may be rejected.',
          ),
        ],
      ),
    );
  }

  // Widget _buildCTASection(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  //     child: ElevatedButton.icon(
  //       onPressed: () => Navigator.pushNamed(context, AppRouter.schedule),
  //       icon: const Icon(Icons.calendar_today),
  //       label: const Text('Schedule a Pickup'),
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: AppTheme.secondaryBlue,
  //         foregroundColor: Colors.white,
  //         padding: const EdgeInsets.symmetric(vertical: 14),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showInfoDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Plastic Waste'),
        content: const Text(
          'Information about our plastic waste management services.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Animated circle widget for background
class _HeroCircle extends StatelessWidget {
  final double? top, left, right, bottom, size, opacity;
  const _HeroCircle({
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.size,
    this.opacity,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(opacity ?? 0.095),
        ),
      ),
    );
  }
}

class _PillGlass extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Color iconColor;
  const _PillGlass({
    required this.text,
    required this.icon,
    this.color = Colors.white,
    this.iconColor = Colors.blue,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color.withOpacity(.16),
        border: Border.all(color: color.withOpacity(.24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 7),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// Animated background ripples (global)
class _BgAnimatedRipples extends StatelessWidget {
  final Color color;
  const _BgAnimatedRipples({required this.color});
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _HeroCircle(top: -70, left: -60, size: 150, opacity: 0.09),
          _HeroCircle(top: 290, right: -80, size: 140, opacity: 0.075),
          _HeroCircle(bottom: -90, left: 140, size: 220, opacity: 0.07),
        ],
      ),
    );
  }
}
