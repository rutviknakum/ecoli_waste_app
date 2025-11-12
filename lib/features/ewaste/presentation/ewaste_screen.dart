// ignore_for_file: unnecessary_import

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';
import '../../../app/router.dart';

class EwasteScreen extends StatefulWidget {
  const EwasteScreen({Key? key}) : super(key: key);

  @override
  State<EwasteScreen> createState() => _EwasteScreenState();
}

class _EwasteScreenState extends State<EwasteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 850),
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
    //final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const CustomDrawer(),
      floatingActionButton: _buildFAB(context),
      body: Stack(
        children: [
          _BgAnimatedRipples(),
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
                  _buildAcceptedItems(),
                  _buildProcessSection(),
                  _buildBenefitsSection(),
                  _buildFAQSection(),
                  _buildCTASection(context),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Modern animated app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'E-Waste Recycling',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => _showInfoDialog(),
          tooltip: 'More Info',
        ),
      ],
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, AppRouter.schedule),
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.calendar_today, size: 21),
      label: const Text(
        'Schedule Pickup',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      elevation: 8,
      heroTag: 'ewaste_fab',
    );
  }

  // HERO with animated background
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen,
            AppTheme.primaryGreen.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        children: [
          // animated circle waves using Positioned
          _HeroCircle(
            top: -55,
            left: null,
            right: -55,
            size: 220,
            opacity: 0.11,
          ),
          _HeroCircle(
            top: null,
            left: -35,
            right: null,
            bottom: -38,
            size: 160,
            opacity: 0.08,
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.33),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 28, color: Colors.black12),
                    ],
                  ),
                  child: const Icon(
                    Icons.computer,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'E-Waste Recycling',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: 10),
                _PillGlass(
                  text: '602.25 Mt/Month Capacity',
                  icon: Icons.flash_on,
                ),
                const SizedBox(height: 10),
                const Text(
                  'First E-Waste recycling plant in Gujarat',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Quick stats with animated icons
  Widget _buildQuickStats() {
    final stats = [
      {'value': '15+', 'label': 'Years Experience', 'icon': Icons.work_history},
      {'value': '10K+', 'label': 'Devices Recycled', 'icon': Icons.recycling},
      {'value': '100%', 'label': 'Eco-Friendly', 'icon': Icons.eco},
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 10),
      child: Row(
        children: stats.map((s) {
          return Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 1200 + stats.indexOf(s) * 250),
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
            color: AppTheme.primaryGreen.withOpacity(0.11),
            blurRadius: 9,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 29),
          const SizedBox(height: 7),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12.5, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green[50]!, Colors.white]),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: AppTheme.primaryGreen,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'About E-Waste',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Electronic waste (e-waste) includes discarded electrical or electronic devices. We specialize in collecting, dismantling, and recycling these materials responsibly, preventing harmful substances from entering the environment while recovering valuable resources.',
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

  Widget _buildAcceptedItems() {
    final items = [
      {
        'icon': Icons.computer,
        'name': 'Computers & Laptops',
        'color': Colors.blue,
      },
      {
        'icon': Icons.phone_android,
        'name': 'Mobile Phones',
        'color': Colors.purple,
      },
      {'icon': Icons.tv, 'name': 'TVs & Monitors', 'color': Colors.orange},
      {'icon': Icons.print, 'name': 'Printers', 'color': Colors.teal},
      {
        'icon': Icons.battery_charging_full,
        'name': 'Batteries',
        'color': Colors.green,
      },
      {'icon': Icons.cable, 'name': 'Cables & Wires', 'color': Colors.red},
      {'icon': Icons.keyboard, 'name': 'Keyboards', 'color': Colors.indigo},
      {'icon': Icons.headphones, 'name': 'Accessories', 'color': Colors.pink},
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
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'We recycle all types of electronic waste',
                  style: TextStyle(
                    color: Colors.green,
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

  // Stylish accepted item
  Widget _AcceptedItemCard({
    required IconData icon,
    required String name,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15.5),
      decoration: BoxDecoration(
        color: color.withOpacity(.07),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.13),
            blurRadius: 13,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(.21)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: color.withOpacity(.13),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, size: 27, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13.8, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Process, Benefits, FAQ, CTA, Info Dialog implementations (minimal, safe defaults)

  Widget _buildProcessSection() {
    final steps = [
      {
        'icon': Icons.search,
        'title': 'Collection',
        'desc': 'We collect devices from homes and offices.',
      },
      {
        'icon': Icons.build,
        'title': 'Dismantle',
        'desc': 'Components are safely separated and sorted.',
      },
      {
        'icon': Icons.recycling,
        'title': 'Recycle',
        'desc': 'Materials are recovered and processed responsibly.',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How It Works',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Column(
            children: steps.map((s) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryGreen.withOpacity(0.12),
                  child: Icon(
                    s['icon'] as IconData,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                title: Text(
                  s['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(s['desc'] as String),
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    final benefits = [
      {'title': 'Protects Environment', 'icon': Icons.nature},
      {'title': 'Recovers Resources', 'icon': Icons.precision_manufacturing},
      {'title': 'Safe Disposal', 'icon': Icons.shield},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Benefits',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: benefits.map((b) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.06),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        b['icon'] as IconData,
                        color: AppTheme.primaryGreen,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        b['title'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
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

  Widget _buildFAQSection() {
    final faqs = [
      {
        'q': 'What items do you accept?',
        'a':
            'We accept most electronic devices including phones, laptops, TVs, batteries and accessories.',
      },
      {
        'q': 'How do I schedule a pickup?',
        'a':
            'Use the Schedule Pickup button or contact our support to arrange collection.',
      },
      {
        'q': 'Is there a fee?',
        'a':
            'Fees depend on item type and condition; some items may be free to recycle.',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FAQ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...faqs.map((f) {
            return ExpansionTile(
              title: Text(
                f['q'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(f['a'] as String),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            const Text(
              'Ready to responsibly recycle your e-waste?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.primaryGreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, AppRouter.schedule),
              child: const Text(
                'Schedule a Pickup',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('More Info'),
          content: const Text(
            'We are committed to safe and eco-friendly e-waste recycling. Contact us for bulk pickups or corporate programs.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// Animated circle for hero BG
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

// Decorative background ripples (global)
class _BgAnimatedRipples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _HeroCircle(top: -60, left: -60, size: 170, opacity: 0.08),
          _HeroCircle(top: 320, right: -60, size: 160, opacity: 0.07),
          _HeroCircle(bottom: -110, left: 170, size: 210, opacity: 0.070),
        ],
      ),
    );
  }
}

// Glistening pill for hero section
class _PillGlass extends StatelessWidget {
  final String text;
  final IconData icon;
  const _PillGlass({required this.text, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(.18),
        border: Border.all(color: Colors.white.withOpacity(.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.10),
            blurRadius: 13,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
