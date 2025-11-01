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
      appBar: AppBar(
        title: const Text('EcoChip E-Waste Management'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Hero Banner with Buttons
            HeroBannerWithButtons(
              title: 'Mine E-Waste, Not Earth',
              subtitle:
                  'E-Coli always invest in betterment of Mother Earth, that\'s why able to provide technically smarter solutions for E-Waste.',
              imageUrl:
                  'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=1200', // Nature/leaves background
              height: 400,
            ),
            const SizedBox(height: 20),

            // Statistics Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Impact',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.0,
                    children: [
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
                        value: '540',
                        label: 'Mt/Month Bio-Medical',
                        icon: Icons.medical_services,
                        color: Colors.red,
                      ),
                      StatisticsCard(
                        value: '252',
                        label: 'Team Members',
                        icon: Icons.people,
                        color: AppTheme.accentOrange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Services Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Services',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildServiceCard(
                    context,
                    title: 'E-Waste Recycling',
                    description:
                        'First E-Waste recycling plant in Gujarat with 602.25 Mt/Month capacity',
                    icon: Icons.computer,
                    color: AppTheme.primaryGreen,
                    route: AppRouter.ewaste,
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Plastic Waste Management',
                    description:
                        'Recycling 500 Mt/Month plastic waste with EPR compliance',
                    icon: Icons.delete,
                    color: AppTheme.secondaryBlue,
                    route: AppRouter.plastic,
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Bio-Medical Waste',
                    description:
                        'Advanced treatment with rotary incineration system',
                    icon: Icons.medical_services,
                    color: Colors.red,
                    route: AppRouter.biomedical,
                  ),
                  _buildServiceCard(
                    context,
                    title: 'Engimech - Pollution Control',
                    description: 'Air & water pollution control devices',
                    icon: Icons.engineering,
                    color: AppTheme.accentOrange,
                    route: AppRouter.engimech,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Reviews Section
            _buildReviewsSection(),
            const SizedBox(height: 30),

            // About Section
            Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About EcoChip',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'EcoChip Waste Management Pvt. Ltd is a waste management company instigated in 2002 with a novel idea of environment conservation through recycling of hazardous E-Waste, Plastic waste and treatment of Bio-Medical waste.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.about);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Learn More'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reviews Section
  Widget _buildReviewsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Client Reviews',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildReviewCard(
                  name: 'Rajesh Kumar',
                  review: 'Excellent service! They collected e-waste promptly.',
                  rating: 5,
                ),
                _buildReviewCard(
                  name: 'Priya Sharma',
                  review: 'Very professional team. Highly recommended.',
                  rating: 5,
                ),
                _buildReviewCard(
                  name: 'Amit Patel',
                  review: 'Great initiative for environment conservation.',
                  rating: 4,
                ),
              ],
            ),
          ),
        ],
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
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primaryGreen,
                  child: Text(
                    name[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(review, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
