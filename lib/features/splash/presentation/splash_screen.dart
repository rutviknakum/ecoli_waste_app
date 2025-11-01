import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  static const _ecoGreen = Color(0xFF4C8B7F);
  // readable dark brown
  static const _bgDark = Color(0xFF2E5E54);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _fade = CurvedAnimation(
      parent: _ac,
      curve: const Interval(0.00, 0.70, curve: Curves.easeIn),
    );
    _scale = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _ac,
        curve: const Interval(0.10, 0.70, curve: Curves.easeOutCubic),
      ),
    );
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ac,
            curve: const Interval(0.10, 0.70, curve: Curves.easeOut),
          ),
        );

    _ac.forward();
    _ac.addStatusListener((s) async {
      if (s == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 400));
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRouter.home);
        }
      }
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_ecoGreen, _bgDark],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Word‑mark rendered as text for pixel‑perfect type
                      Text(
                        'EcoChip',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: Colors.white,
                          height: 1.12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'E‑Waste',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          color: Color(0xFFF2EDEB), // light on dark gradient
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Reduce • Recycle • Reuse',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1.0,
                          color: Colors.white.withOpacity(0.82),
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 36),
                      const SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.6,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
