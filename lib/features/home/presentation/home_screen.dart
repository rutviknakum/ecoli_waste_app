import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../shared/widgets/hero_banner.dart';
import '../../../shared/widgets/statistics_card.dart';
import '../../../core/themes/app_theme.dart';
import '../../../app/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Coli Waste Management'), centerTitle: true),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            HeroBanner(
              title: 'Think Out of Trash Box',
              subtitle: 'Environment conservation through waste recycling',
            ),
            SizedBox(height: 20),

            // Statistics Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Impact',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
            SizedBox(height: 30),

            // Services Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Services',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
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
            SizedBox(height: 30),

            // About Section
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About E-Coli',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'E-Coli Waste Management Pvt. Ltd is a waste management company instigated in 2002 with a novel idea of environment conservation through recycling of hazardous E-Waste, Plastic waste and treatment of Bio-Medical waste.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.about);
                    },
                    child: Text('Learn More'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
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

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
