import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';
import '../../../app/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> quoteImages = [
    "assets/images/generated-image (1).png",
    "assets/images/generated-image (2).png",
    "assets/images/generated-image.png",
  ];

  final int ewasteCount = 26;
  final int recyclingCount = 38;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF171C23)
          : const Color(0xFFF6FAF6),
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppTheme.primaryGreen,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isDark ? 'assets/logo-dark.png' : 'assets/logo.png',
              height: 34,
              width: 34,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.verified, size: 34, color: AppTheme.primaryGreen),
            ),
            const SizedBox(width: 8),
            Text(
              "EcoChip",
              style: TextStyle(
                color: isDark ? Colors.white : AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRouter.aiChat),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.smart_toy),
        label: const Text(
          "AI Assistant",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 30),
        children: [
          // Greeting section
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi there,",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Welcome to EcoChip Waste Management.",
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[200] : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          // Carousel with image cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CarouselSlider(
              items: quoteImages
                  .map(
                    (path) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.11),
                            blurRadius: 14,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          path,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 160,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 160,
                enlargeCenterPage: true,
                viewportFraction: .92,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Services section (responsive)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader('Our Services'),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, box) {
                    double cardWidth = (box.maxWidth - 16) / 2;
                    cardWidth = cardWidth < 135 ? box.maxWidth : cardWidth;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 14,
                      alignment: WrapAlignment.start,
                      children: [
                        _serviceCard(
                          icon: Icons.recycling,
                          color: AppTheme.primaryGreen,
                          title: "E-Waste Pickup",
                          count: ewasteCount,
                          onTap: () =>
                              Navigator.of(context).pushNamed(AppRouter.ewaste),
                          width: cardWidth,
                        ),
                        _serviceCard(
                          icon: Icons.eco_rounded,
                          color: const Color(0xFF43A047),
                          title: "Eco Recycling",
                          count: recyclingCount,
                          onTap: () => Navigator.of(
                            context,
                          ).pushNamed(AppRouter.plastic),
                          width: cardWidth,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Statistics section (responsive)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader('Our Impact'),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, box) {
                    double cardWidth = (box.maxWidth - 24) / 2;
                    cardWidth = cardWidth < 135 ? box.maxWidth : cardWidth;
                    final stats = [
                      _Stat(
                        icon: Icons.computer,
                        color: AppTheme.primaryGreen,
                        label: "E-Waste",
                        value: "602 Mt/mo",
                      ),
                      _Stat(
                        icon: Icons.delete_outline_rounded,
                        color: const Color(0xFF1E88E5),
                        label: "Plastic",
                        value: "500 Mt/mo",
                      ),
                      _Stat(
                        icon: Icons.people_alt,
                        color: const Color(0xFFA77B06),
                        label: "Clients",
                        value: "1,500+",
                      ),
                      _Stat(
                        icon: Icons.public,
                        color: Colors.green,
                        label: "CO₂ Saved",
                        value: "420T+",
                      ),
                    ];
                    return Wrap(
                      spacing: 12,
                      runSpacing: 14,
                      children: stats
                          .map(
                            (s) => _statCard(
                              icon: s.icon,
                              color: s.color,
                              label: s.label,
                              value: s.value,
                              width: cardWidth,
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),

          // Reviews/testimonials (responsive)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader('What Clients Say'),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, box) {
                    double cardWidth = (box.maxWidth - 24) / 2;
                    cardWidth = cardWidth < 170 ? box.maxWidth : cardWidth;
                    final reviews = [
                      _Review(
                        user: "Priya Sharma",
                        text:
                            "Prompt pickup. EcoChip truly cares about recycling.",
                        rating: 5,
                      ),
                      _Review(
                        user: "Amit Patel",
                        text:
                            "Fast service, clear tracking, and professional staff.",
                        rating: 5,
                      ),
                      _Review(
                        user: "R. Kumar",
                        text:
                            "E-waste disposal made super easy. Will use again.",
                        rating: 4,
                      ),
                    ];
                    return Wrap(
                      spacing: 16,
                      runSpacing: 14,
                      children: reviews
                          .map((r) => _reviewCard(review: r, width: cardWidth))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 21),

          // Bottom Call-to-Action
          _ctaCard(context),
        ],
      ),
    );
  }

  Widget _sectionHeader(String s) => Padding(
    padding: const EdgeInsets.only(left: 2, bottom: 7),
    child: Text(
      s,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        letterSpacing: 0.05,
      ),
    ),
  );

  Widget _serviceCard({
    required IconData icon,
    required Color color,
    required String title,
    required int count,
    required VoidCallback onTap,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Card(
        elevation: 3,
        color: color.withOpacity(.09),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                Icon(icon, size: 27, color: color),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: Text(
                    "$count",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Card(
        color: Colors.white,
        elevation: 2.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 25),
              const SizedBox(height: 7),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reviewCard({required _Review review, required double width}) {
    return SizedBox(
      width: width,
      child: Card(
        color: Colors.white,
        elevation: 2.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryGreen,
                    radius: 16,
                    child: Text(
                      review.user[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      review.user,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (idx) => Icon(
                        idx < review.rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                review.text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ctaCard(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Colors.white, size: 27),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Book a Pickup",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Let EcoChip handle your e-waste—safe & easy.",
                  style: TextStyle(fontSize: 12.9, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: const Text(
              'Book',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Review {
  final String user;
  final String text;
  final int rating;
  const _Review({required this.user, required this.text, required this.rating});
}

class _Stat {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  const _Stat({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });
}
