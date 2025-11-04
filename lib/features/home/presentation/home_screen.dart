import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../shared/widgets/hero_banner_with_buttons.dart';
import '../../../shared/widgets/statistics_card.dart';
import '../../../core/themes/app_theme.dart';
import '../../../app/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const CustomDrawer(),
      floatingActionButton: _buildFAB(context),
      body: _buildBody(),
    );
  }

  // ========== APP BAR ==========
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('EcoChip E-Waste Management'),
      centerTitle: true,
      elevation: 0,
    );
  }

  // ========== FLOATING ACTION BUTTON ==========
  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, AppRouter.aiChat),
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.smart_toy, size: 20),
      label: const Text(
        'AI Assistant',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      elevation: 6,
      heroTag: 'ai_assistant_fab',
    );
  }

  // ========== MAIN BODY ==========
  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Banner
          _buildHeroBanner(),

          // 2. Statistics Section
          _buildStatisticsSection(),

          // 3. Services Section
          _buildServicesSection(),

          // 4. Reviews Section
          _buildReviewsSection(),

          // 5. About Section
          _buildAboutSection(),

          // Bottom padding for FAB
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // ========== HERO BANNER ==========
  Widget _buildHeroBanner() {
    return const HeroBannerWithButtons(
      title: 'Mine E-Waste, Not Earth',
      subtitle:
          'EcoChip always invests in betterment of Mother Earth, that\'s why we\'re able to provide technically smarter solutions for E-Waste.',
      imageUrl:
          'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=1200&q=80',
      height: 450,
    );
  }

  // ========== STATISTICS SECTION ==========
  Widget _buildStatisticsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Our Impact'),
          const SizedBox(height: 16),
          _buildStatisticsGrid(),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: const [
        StatisticsCard(
          value: '602.25',
          label: 'Mt/Month E-Waste',
          icon: Icons.computer,
          color: AppTheme.primaryGreen,
        ),
        StatisticsCard(
          value: '500',
          label: 'Mt/Month Plastic',
          icon: Icons.delete,
          color: AppTheme.secondaryBlue,
        ),
        StatisticsCard(
          value: '252',
          label: 'Team Members',
          icon: Icons.people,
          color: AppTheme.accentOrange,
        ),
        StatisticsCard(
          value: '15+',
          label: 'Years Experience',
          icon: Icons.work_history,
          color: Color(0xFF9C27B0),
        ),
      ],
    );
  }

  // ========== SERVICES SECTION ==========
  Widget _buildServicesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Our Services'),
          const SizedBox(height: 16),
          _buildServiceCard(
            title: 'E-Waste Recycling',
            description:
                'First E-Waste recycling plant in Gujarat with 602.25 Mt/Month capacity',
            icon: Icons.computer,
            color: AppTheme.primaryGreen,
            route: AppRouter.ewaste,
          ),
          _buildServiceCard(
            title: 'Plastic Waste Management',
            description:
                'Recycling 500 Mt/Month plastic waste with EPR compliance',
            icon: Icons.delete,
            color: AppTheme.secondaryBlue,
            route: AppRouter.plastic,
          ),
        ],
      ),
    );
  }

  // ========== REVIEWS SECTION ==========
  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: _buildSectionTitle('Client Reviews'),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16),
              children: [
                _buildReviewCard(
                  name: 'Rajesh Kumar',
                  review:
                      'Excellent service! They collected e-waste promptly and professionally.',
                  rating: 5,
                ),
                _buildReviewCard(
                  name: 'Priya Sharma',
                  review:
                      'Very professional team. Highly recommended for waste management.',
                  rating: 5,
                ),
                _buildReviewCard(
                  name: 'Amit Patel',
                  review:
                      'Great initiative for environment conservation. Keep up the good work!',
                  rating: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========== ABOUT SECTION ==========
  Widget _buildAboutSection() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      color: Colors.grey[100],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About EcoChip'),
          const SizedBox(height: 16),
          Text(
            'EcoChip Waste Management Pvt. Ltd is a waste management company established in 2002 with a novel idea of environment conservation through recycling of hazardous E-Waste and Plastic waste.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Will be implemented with router
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Learn More',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ========== REUSABLE WIDGETS ==========

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Will navigate using route
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String review,
    required int rating,
  }) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primaryGreen,
                  radius: 24,
                  child: Text(
                    name[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              review,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
