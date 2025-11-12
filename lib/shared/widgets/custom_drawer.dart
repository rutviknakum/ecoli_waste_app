import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/router.dart';
import '../../core/themes/app_theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          // Ripple background effect
          _RippleBg(),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              // Glassmorphic header with pop profile/brand logo
              Container(
                height: 180,
                child: Stack(
                  children: [
                    // Glass layer
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(color: Colors.white.withOpacity(0.21)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 35, 18, 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.primaryGreen,
                                width: 4.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryGreen.withOpacity(
                                    0.22,
                                  ),
                                  blurRadius: 18,
                                  spreadRadius: .2,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage(
                                'assets/logo.png',
                              ),
                              child: Image.asset(
                                'assets/logo.png',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.eco,
                                  size: 38,
                                  color: AppTheme.primaryGreen,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EcoChip",
                                  style: TextStyle(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryGreen.withOpacity(
                                      0.13,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                        size: 15,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "Certified Eco Brand",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.7,
                                          color: Colors.green,
                                        ),
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
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _drawerSection("Main", Icons.star, color: AppTheme.primaryGreen),
              _navPill(context, Icons.home, "Home", AppRouter.home),
              _navPill(
                context,
                Icons.person,
                "User Profile",
                AppRouter.profile,
              ),
              _navPill(
                context,
                Icons.schedule,
                "Schedule Pickup",
                AppRouter.schedule,
              ),
              _navPill(
                context,
                Icons.smart_toy,
                "AI Assistant",
                AppRouter.aiChat,
              ),
              _navPill(
                context,
                Icons.computer,
                "E-Waste Recycling",
                AppRouter.ewaste,
              ),
              _navPill(
                context,
                Icons.delete,
                "Plastic Waste",
                AppRouter.plastic,
              ),
              _drawerSection(
                "Information",
                Icons.info_outline,
                color: Colors.blue[400]!,
              ),
              _navPill(context, Icons.info, "About Us", AppRouter.about),
              _navPill(
                context,
                Icons.factory,
                "Facilities",
                AppRouter.facilities,
              ),
              _navPill(
                context,
                Icons.campaign,
                "Awareness",
                AppRouter.awareness,
              ),

              _navPill(
                context,
                Icons.contact_phone,
                "Contact Us",
                AppRouter.contact,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawerSection(String label, IconData icon, {required Color color}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 20, 0, 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: color.withOpacity(.17),
            child: Icon(icon, color: color, size: 17),
          ),
          const SizedBox(width: 13),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 14.4,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _navPill(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.5),
      child: Material(
        color: theme.brightness == Brightness.dark
            ? Colors.white10
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            child: Row(
              children: [
                Icon(icon, color: AppTheme.primaryGreen, size: 21),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15.3,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Decorative background ripples
class _RippleBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          _Circle(
            color: AppTheme.primaryGreen.withOpacity(0.10),
            left: -100,
            top: -40,
            radius: 130,
          ),
          _Circle(
            color: Colors.green.withOpacity(0.08),
            left: 180,
            top: -50,
            radius: 80,
          ),
          _Circle(
            color: Colors.greenAccent.withOpacity(0.11),
            left: 0,
            top: 210,
            radius: 120,
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final Color color;
  final double left, top, radius;
  const _Circle({
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
