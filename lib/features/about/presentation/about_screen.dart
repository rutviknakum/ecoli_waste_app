import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.13), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
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
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroSection(context),
                    _buildQuickStats(),
                    _buildStorySection(),
                    _buildMissionVision(),
                    _buildValues(),
                    _buildTimeline(),
                    _buildAchievements(),
                    _buildTeamShowcase(),
                    _buildCertifications(),
                    _buildCallToAction(),
                    const SizedBox(height: 36),
                  ],
                ),
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
        'About EcoChip',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
          tooltip: 'Share',
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryGreen,
                  AppTheme.primaryGreen.withOpacity(0.8),
                  AppTheme.secondaryBlue.withOpacity(0.5),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 34),
              child: Column(
                children: [
                  // Glass logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.22),
                            width: 2.3,
                          ),
                        ),
                        child: const Icon(
                          Icons.eco_outlined,
                          size: 85,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Titles
                  const Text(
                    'EcoChip',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.16),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Waste Management Pvt. Ltd',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  // Badges/bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _HeroBadge(label: 'Founded 2002'),
                      const SizedBox(width: 10),
                      _HeroBadge(label: 'ISO 14001'),
                      const SizedBox(width: 10),
                      _HeroBadge(label: 'EPR Certified'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Subtitle
                  Text(
                    'Pioneering sustainable waste solutions in India.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.7,
                      color: Colors.white.withOpacity(.84),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final stats = [
      {
        'value': '23+',
        'label': 'Years',
        'icon': Icons.calendar_today,
        'color': Colors.green,
      },
      {
        'value': '1100+',
        'label': 'Mt/Month',
        'icon': Icons.recycling,
        'color': Colors.blue,
      },
      {
        'value': '252+',
        'label': 'Team',
        'icon': Icons.people,
        'color': Colors.orange,
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: Row(
        children: stats.map((s) {
          return Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.4, end: 1),
              duration: Duration(milliseconds: 1100 + stats.indexOf(s) * 210),
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: _buildStatCard(
                    s['value'] as String,
                    s['label'] as String,
                    s['icon'] as IconData,
                    s['color'] as Color,
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: color.withOpacity(.18),
              borderRadius: BorderRadius.circular(19),
            ),
            child: Icon(icon, color: color, size: 31),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 19.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 13, color: color.withOpacity(.81)),
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 19),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Our Story',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Founded in 2002, we deliver sustainable waste solutions and have become an industry leader in recycling and environmental services.',
                style: TextStyle(fontSize: 14.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissionVision() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _MVCard(
              title: 'Mission',
              desc:
                  'To provide advanced waste management that goes beyond compliance and truly makes a difference.',
              color: AppTheme.primaryGreen,
              icon: Icons.rocket_launch,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: _MVCard(
              title: 'Vision',
              desc:
                  'A world where all resources are reused and our planet thrives.',
              color: AppTheme.secondaryBlue,
              icon: Icons.visibility_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValues() {
    final values = [
      {
        'label': 'Integrity',
        'icon': Icons.verified,
        'color': Colors.green[700],
      },
      {'label': 'Sustainability', 'icon': Icons.eco, 'color': Colors.blue[600]},
      {
        'label': 'Innovation',
        'icon': Icons.lightbulb,
        'color': Colors.orange[800],
      },
      {
        'label': 'Community',
        'icon': Icons.people_alt_rounded,
        'color': Colors.purple[300],
      },
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 5),
      child: Wrap(
        spacing: 13,
        runSpacing: 13,
        children: values.map((v) {
          return Chip(
            label: Text(v['label'] as String),
            avatar: Icon(v['icon'] as IconData, color: v['color'] as Color),
            backgroundColor: (v['color'] as Color?)?.withOpacity(0.14),
            side: BorderSide(color: (v['color'] as Color?)!.withOpacity(.20)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimeline() {
    final milestones = [
      {'year': '2002', 'title': 'Founded', 'desc': 'Established in Gujarat'},
      {'year': '2010', 'title': 'Innovation', 'desc': 'First recycling plant'},
      {'year': '2018', 'title': 'Growth', 'desc': 'All-India operations'},
      {'year': '2022', 'title': 'Leadership', 'desc': '250+ member team'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timeline',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...milestones.map(
            (m) => Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 13, bottom: 9),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryGreen.withOpacity(0.13),
                    border: Border.all(
                      color: AppTheme.primaryGreen.withOpacity(.23),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      m['year'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      m['desc'] as String,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {'emoji': '🏆', 'title': 'Awarded', 'desc': 'Industry Pioneer'},
      {
        'emoji': '♻️',
        'title': 'Impact',
        'desc': 'Largest recycling in Gujarat',
      },
      {'emoji': '💯', 'title': 'Reputation', 'desc': 'Trusted by 250+ firms'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Achievements',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          ...achievements.map(
            (a) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(11),
              ),
              child: ListTile(
                leading: Text(
                  a['emoji'] as String,
                  style: const TextStyle(fontSize: 22),
                ),
                title: Text(
                  a['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(a['desc'] as String),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamShowcase() {
    final team = [
      {
        'role': 'Leadership',
        'desc': 'Management Team',
        'icon': Icons.business_center,
        'color': Colors.blue,
      },
      {
        'role': 'Field Ops',
        'desc': 'Field Specialists',
        'icon': Icons.precision_manufacturing,
        'color': Colors.green,
      },
      {
        'role': 'QA Experts',
        'desc': 'Quality Control',
        'icon': Icons.verified,
        'color': Colors.purple,
      },
      {
        'role': 'Support',
        'desc': 'Customer Care',
        'icon': Icons.support_agent,
        'color': Colors.orange,
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 14, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Team',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 9),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => _TeamCard(
                title: team[i]['role'] as String,
                subtitle: team[i]['desc'] as String,
                icon: team[i]['icon'] as IconData,
                color: team[i]['color'] as Color,
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: team.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertifications() {
    final certs = [
      'EPR Authorization',
      'ISO 9001:2015',
      'Environmental Compliance',
      'CPCB Guidelines',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Certifications',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 11),
          Wrap(
            spacing: 8,
            runSpacing: 9,
            children: certs
                .map(
                  (c) => Chip(
                    label: Text(c),
                    backgroundColor: AppTheme.primaryGreen.withOpacity(.16),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction() {
    return Container(
      margin: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryGreen, AppTheme.secondaryBlue],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.17),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.19),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone_in_talk,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 19),
              const Text(
                'Let\'s Connect',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Partner with us for sustainable waste management',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward_rounded, size: 22),
                label: const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 13,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Badges for hero
class _HeroBadge extends StatelessWidget {
  final String label;
  const _HeroBadge({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.19),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(.23)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 11.5,
        ),
      ),
    );
  }
}

// Mission/Vision glassy cards
class _MVCard extends StatelessWidget {
  final String title, desc;
  final Color color;
  final IconData icon;
  const _MVCard({
    required this.title,
    required this.desc,
    required this.color,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withOpacity(.12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(fontSize: 13.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

// Horizontal card for teams
class _TeamCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  const _TeamCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: color.withOpacity(0.13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.18)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: color.withOpacity(0.87)),
          ),
        ],
      ),
    );
  }
}

// Animated ripple background
class _BgAnimatedRipples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _HeroCircle(top: -70, left: -70, size: 130, opacity: 0.09),
          _HeroCircle(top: 240, right: -70, size: 110, opacity: 0.07),
          _HeroCircle(bottom: -110, left: 140, size: 210, opacity: 0.07),
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
