import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({Key? key}) : super(key: key);

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen>
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
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const CustomDrawer(),
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
                  _buildHeroSection(),
                  _buildOverview(),
                  _buildFacilities(),
                  _buildInfrastructure(),
                  _buildTechnology(),
                  _buildSafety(),
                  _buildCapacity(),
                  _buildCTASection(),
                  const SizedBox(height: 40),
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
        'Our Facilities',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen,
            AppTheme.primaryGreen.withOpacity(0.83),
            AppTheme.secondaryBlue.withOpacity(0.4),
          ],
        ),
      ),
      child: Stack(
        children: [
          _HeroCircle(top: -60, right: -60, size: 220, opacity: 0.10),
          _HeroCircle(bottom: -40, left: -40, size: 160, opacity: 0.09),
          Padding(
            padding: const EdgeInsets.all(34),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white.withOpacity(.2)),
                      ),
                      child: const Icon(
                        Icons.factory,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                const Text(
                  'State-of-the-Art\nFacilities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                    height: 1.13,
                  ),
                ),
                const SizedBox(height: 11),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.17),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    "Gujarat's Premier Recycling Hub",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryGreen,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Facility Overview',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              const Text(
                'EcoChip operates cutting-edge waste management facilities designed with the latest technology and environmental standards. Our plants are equipped to handle large-scale recycling operations while maintaining strict safety and quality protocols.',
                style: TextStyle(fontSize: 15, height: 1.7),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacilities() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Main Facilities',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          _buildFacilityCard(
            'E-Waste Recycling Plant',
            '602.2 Mt/Month Capacity',
            'Advanced dismantling & data destruction.',
            Icons.computer,
            AppTheme.primaryGreen,
            [
              'Automated sorting systems',
              'Material recovery units',
              'Data security lab',
            ],
          ),
          const SizedBox(height: 16),
          _buildFacilityCard(
            'Plastic Recycling Unit',
            '500 Mt/Month Capacity',
            'Modern EPR-compliant facility.',
            Icons.recycling,
            AppTheme.secondaryBlue,
            [
              'Multi-grade sorting',
              'Washing & cleaning line',
              'Pelletizing systems',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityCard(
    String title,
    String capacity,
    String description,
    IconData icon,
    Color color,
    List<String> features,
  ) {
    // Build feature rows as a list, then expand in the column
    final featureRows = features
        .map(
          (feature) => Row(
            children: [
              const Icon(Icons.check, color: Colors.green, size: 16),
              const SizedBox(width: 6),
              Text(feature, style: const TextStyle(fontSize: 13.5)),
            ],
          ),
        )
        .toList();

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.09),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 16.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text(
                          capacity,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 14.2, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            ...featureRows, // expand the list of feature Rows here
          ],
        ),
      ),
    );
  }

  Widget _buildInfrastructure() {
    final infra = [
      {'label': 'Warehousing', 'icon': Icons.warehouse, 'color': Colors.orange},
      {'label': 'Fleet', 'icon': Icons.local_shipping, 'color': Colors.blue},
      {'label': 'Lab', 'icon': Icons.science, 'color': Colors.purple},
      {'label': 'Admin', 'icon': Icons.business, 'color': Colors.teal},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Infrastructure',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 9),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: infra
                .map(
                  (s) => Chip(
                    label: Text(s['label'] as String),
                    avatar: Icon(
                      s['icon'] as IconData,
                      color: s['color'] as Color,
                    ),
                    backgroundColor: (s['color'] as Color).withOpacity(0.13),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnology() {
    final techs = [
      {
        'title': 'AI Sorting',
        'desc': 'Automated segregation',
        'color': Colors.purple,
      },
      {
        'title': 'Advanced Shredders',
        'desc': 'High volume processing',
        'color': Colors.green,
      },
      {
        'title': 'Material Recovery',
        'desc': 'Metals & plastics extraction',
        'color': Colors.blue,
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Technology & Equipment',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 13),
          ...techs.map(
            (t) => Card(
              color: (t['color'] as Color).withOpacity(.09),
              child: ListTile(
                leading: Icon(Icons.psychology, color: t['color'] as Color),
                title: Text(
                  t['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: t['color'] as Color,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(t['desc'] as String),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafety() {
    final items = [
      {
        'title': 'Fire Safety',
        'desc': 'Detection/suppression',
        'color': Colors.red,
      },
      {
        'title': 'Worker PPE',
        'desc': 'Equipment/training',
        'color': Colors.orange,
      },
      {
        'title': 'Environmental',
        'desc': 'Air/water monitoring',
        'color': Colors.green,
      },
      {
        'title': 'Emergency Response',
        'desc': '24/7 readiness',
        'color': Colors.purple,
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Safety',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...items.map(
                (it) => Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: (it['color'] as Color).withOpacity(.19),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shield,
                        color: it['color'] as Color,
                        size: 17,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            it['title'] as String,
                            style: TextStyle(
                              color: it['color'] as Color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            it['desc'] as String,
                            style: const TextStyle(fontSize: 13.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCapacity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: _CapacityCard(
              label: "E-Waste",
              value: "602.2",
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _CapacityCard(
              label: "Plastic",
              value: "500",
              color: AppTheme.secondaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryGreen, AppTheme.secondaryBlue],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.19),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 33, horizontal: 18),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.19),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.tour, size: 44, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Visit Our Facilities',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Schedule a tour to see our advanced recycling in action',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward, size: 20),
                label: const Text(
                  'Schedule Tour',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 29,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CapacityCard extends StatelessWidget {
  final String label, value;
  final Color color;
  const _CapacityCard({
    required this.label,
    required this.value,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      color: color.withOpacity(.09),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "Mt/Month",
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
            ),
            const SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(.14),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BgAnimatedRipples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _HeroCircle(top: -70, left: -70, size: 120, opacity: 0.08),
          _HeroCircle(top: 320, right: -100, size: 170, opacity: 0.07),
          _HeroCircle(bottom: -110, left: 110, size: 190, opacity: 0.06),
        ],
      ),
    );
  }
}

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
          color: Colors.white.withOpacity(opacity ?? 0.1),
        ),
      ),
    );
  }
}
