import 'package:flutter/material.dart';
import '../../app/router.dart';
import '../../core/themes/app_theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryGreen, AppTheme.secondaryBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.recycling, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Waste Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            route: AppRouter.home,
          ),
          _buildSectionHeader('Main Services'),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'User Profile',
            route: AppRouter.profile,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.schedule,
            title: 'Schedule Pickup',
            route: AppRouter.schedule,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.smart_toy,
            title: 'AI Assistant',
            route: AppRouter.aiChat,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.computer,
            title: 'E-Waste Recycling',
            route: AppRouter.ewaste,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.delete,
            title: 'Plastic Waste',
            route: AppRouter.plastic,
          ),

          _buildDrawerItem(
            context,
            icon: Icons.engineering,
            title: 'Engimech',
            route: AppRouter.engimech,
          ),
          Divider(),
          _buildSectionHeader('Information'),
          _buildDrawerItem(
            context,
            icon: Icons.info,
            title: 'About Us',
            route: AppRouter.about,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.factory,
            title: 'Facilities',
            route: AppRouter.facilities,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.campaign,
            title: 'Awareness Programs',
            route: AppRouter.awareness,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.emoji_events,
            title: 'Awards',
            route: AppRouter.awards,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.contact_phone,
            title: 'Contact Us',
            route: AppRouter.contact,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryGreen),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
