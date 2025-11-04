import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_drawer.dart';
import '../../../core/themes/app_theme.dart';

class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen({Key? key}) : super(key: key);

  @override
  State<AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<AwarenessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedCategory = 0;

  final List<AwarenessCategory> _categories = [
    AwarenessCategory(
      title: 'E-Waste',
      icon: Icons.computer,
      color: Colors.blue,
    ),
    AwarenessCategory(
      title: 'Plastic',
      icon: Icons.recycling,
      color: Colors.green,
    ),
    AwarenessCategory(
      title: 'Environment',
      icon: Icons.eco,
      color: Colors.orange,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              _buildCategoryTabs(),
              _buildContent(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ========== APP BAR ==========
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Awareness',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }

  // ========== HERO SECTION ==========
  Widget _buildHeroSection() {
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
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Learn & Act',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Education is the first step towards\na sustainable future',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
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

  // ========== CATEGORY TABS ==========
  Widget _buildCategoryTabs() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: index < _categories.length - 1 ? 8 : 0,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            category.color,
                            category.color.withOpacity(0.7),
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? category.color : Colors.grey[300]!,
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: category.color.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      category.icon,
                      color: isSelected ? Colors.white : Colors.grey[600],
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ========== CONTENT ==========
  Widget _buildContent() {
    switch (_selectedCategory) {
      case 0:
        return _buildEWasteContent();
      case 1:
        return _buildPlasticContent();
      case 2:
        return _buildEnvironmentContent();
      default:
        return const SizedBox();
    }
  }

  // ========== E-WASTE CONTENT ==========
  Widget _buildEWasteContent() {
    return Column(
      children: [
        _buildInfoCard(
          'What is E-Waste?',
          'Electronic waste or e-waste describes discarded electrical or electronic devices. '
              'This includes computers, mobile phones, TVs, and other electronic equipment.',
          Icons.info_outline,
          Colors.blue,
        ),
        _buildImpactSection('Global Impact', [
          ImpactStat('50M', 'Tons of e-waste generated annually'),
          ImpactStat('20%', 'Only recycled globally'),
          ImpactStat('💰', 'Precious metals worth billions lost'),
        ], Colors.blue),
        _buildDidYouKnow('Did You Know?', [
          'One million recycled cell phones can recover 35,000 lbs of copper, 772 lbs of silver, 75 lbs of gold, and 33 lbs of palladium.',
          'E-waste contains toxic materials like lead, mercury, and cadmium that can harm the environment.',
          'Recycling one million laptops saves enough energy to power 3,500 homes for a year.',
        ], Colors.blue),
        _buildRecyclingGuide('How to Recycle E-Waste', [
          RecyclingStep(
            '1',
            'Backup Data',
            'Save all important files and information',
          ),
          RecyclingStep(
            '2',
            'Delete Data',
            'Wipe all personal information securely',
          ),
          RecyclingStep(
            '3',
            'Remove Batteries',
            'Separate batteries if possible',
          ),
          RecyclingStep(
            '4',
            'Find Collection',
            'Use EcoChip or authorized collectors',
          ),
        ], Colors.blue),
      ],
    );
  }

  // ========== PLASTIC CONTENT ==========
  Widget _buildPlasticContent() {
    return Column(
      children: [
        _buildInfoCard(
          'Plastic Pollution Crisis',
          'Plastic waste is one of the most pressing environmental issues. Over 300 million tons of plastic are produced globally each year, with a significant portion ending up in landfills and oceans.',
          Icons.info_outline,
          Colors.green,
        ),
        _buildImpactSection('Alarming Statistics', [
          ImpactStat('8M', 'Tons enter oceans annually'),
          ImpactStat('500', 'Years to decompose naturally'),
          ImpactStat('🐢', 'Harms 1M+ marine animals yearly'),
        ], Colors.green),
        _buildPlasticTypes(),
        _buildDidYouKnow('Plastic Facts', [
          'A single plastic bottle can take 450 years to decompose in a landfill.',
          'Recycling one ton of plastic saves 7.4 cubic yards of landfill space.',
          'Only 9% of all plastic ever produced has been recycled.',
        ], Colors.green),
        _buildRecyclingGuide('Reduce Plastic Waste', [
          RecyclingStep('1', 'Refuse', 'Say no to single-use plastics'),
          RecyclingStep('2', 'Reduce', 'Use reusable bags and containers'),
          RecyclingStep('3', 'Reuse', 'Find creative ways to reuse items'),
          RecyclingStep('4', 'Recycle', 'Properly sort and recycle plastics'),
        ], Colors.green),
      ],
    );
  }

  // ========== ENVIRONMENT CONTENT ==========
  Widget _buildEnvironmentContent() {
    return Column(
      children: [
        _buildInfoCard(
          'Environmental Impact',
          'Proper waste management is crucial for protecting our environment. Improper disposal leads to pollution, habitat destruction, and climate change.',
          Icons.info_outline,
          Colors.orange,
        ),
        _buildImpactSection('Climate Impact', [
          ImpactStat('2.1B', 'Tons of waste generated annually'),
          ImpactStat('5%', 'Of global GHG from waste'),
          ImpactStat('🌍', 'Affects all ecosystems'),
        ], Colors.orange),
        _buildBenefitsSection(),
        _buildDidYouKnow('Environmental Facts', [
          'Recycling aluminum cans saves 95% of the energy needed to make new ones.',
          'Composting reduces methane emissions from landfills.',
          'One recycled plastic bottle saves enough energy to power a laptop for 3 hours.',
        ], Colors.orange),
        _buildActionItems(),
      ],
    );
  }

  // ========== REUSABLE WIDGETS ==========

  Widget _buildInfoCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), Colors.white],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
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

  Widget _buildImpactSection(
    String title,
    List<ImpactStat> stats,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...stats.map(
            (stat) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        stat.value,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      stat.description,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildDidYouKnow(String title, List<String> facts, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.amber[50]!, Colors.orange[50]!],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates, color: Colors.amber[700], size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...facts.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.amber[700],
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
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

  Widget _buildRecyclingGuide(
    String title,
    List<RecyclingStep> steps,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...steps.map(
            (step) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.7)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        step.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
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

  Widget _buildPlasticTypes() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recyclable Plastic Types',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPlasticType(
            'PET (1)',
            'Water bottles, soft drinks',
            Colors.blue,
          ),
          _buildPlasticType(
            'HDPE (2)',
            'Milk jugs, shampoo bottles',
            Colors.green,
          ),
          _buildPlasticType(
            'PP (5)',
            'Yogurt containers, bottle caps',
            Colors.orange,
          ),
          _buildPlasticType(
            'LDPE (4)',
            'Shopping bags, squeeze bottles',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildPlasticType(String code, String examples, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(examples, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green[50]!, Colors.blue[50]!]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.eco, color: Colors.green[700], size: 28),
              const SizedBox(width: 12),
              const Text(
                'Benefits of Recycling',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBenefitItem('Conserves natural resources'),
          _buildBenefitItem('Reduces pollution and greenhouse gases'),
          _buildBenefitItem('Saves energy and reduces emissions'),
          _buildBenefitItem('Creates jobs and boosts economy'),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green[700], size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildActionItems() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.orange.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.volunteer_activism, size: 56, color: Colors.white),
          const SizedBox(height: 20),
          const Text(
            'Take Action Today',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Small changes make big impacts.\nStart your recycling journey now!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to schedule
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Schedule Pickup',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========== DATA MODELS ==========

class AwarenessCategory {
  final String title;
  final IconData icon;
  final Color color;

  AwarenessCategory({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class ImpactStat {
  final String value;
  final String description;

  ImpactStat(this.value, this.description);
}

class RecyclingStep {
  final String number;
  final String title;
  final String description;

  RecyclingStep(this.number, this.title, this.description);
}
