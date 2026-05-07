import 'package:flutter/material.dart';
import 'package:wasla/core/utils/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView>
    with TickerProviderStateMixin {
  // Controllers
  late AnimationController _dropCtrl;
  late AnimationController _growCtrl;
  late AnimationController _logoCtrl;
  late AnimationController _lettersCtrl;
  late AnimationController _taglineCtrl;

  // Animations
  late Animation<double> _logoOpacity;
  late Animation<double> _logoScale;
  late Animation<double> _taglineOpacity;
  late Animation<Offset> _taglineSlide;

  // للحروف
  final String _word = "WASLA";
  final List<double> _letterOpacity = [];
  final List<double> _letterY = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < _word.length; i++) {
      _letterOpacity.add(0.0);
      _letterY.add(40.0);
    }

    _dropCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _growCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _lettersCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _taglineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOut));
    _logoScale = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut));

    _taglineOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _taglineCtrl, curve: Curves.easeOut));
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _taglineCtrl, curve: Curves.easeOut));

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));

    // 1. دايرة نازلة
    await _dropCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 200));

    // 2. بتكبر وتملأ
    await _growCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 100));

    // 3. اللوجو
    await _logoCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 400));

    // 4. حروف واحدة واحدة
    for (int i = 0; i < _word.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _letterOpacity[i] = 1.0;
        _letterY[i] = 0.0;
      });
    }

    await Future.delayed(const Duration(milliseconds: 500));

    // 5. tagline
    await _taglineCtrl.forward();

    // انتقل للهوم
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _dropCtrl.dispose();
    _growCtrl.dispose();
    _logoCtrl.dispose();
    _lettersCtrl.dispose();
    _taglineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxDiameter = size.longestSide * 2.5;
    final centerY = size.height / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ── الدايرة ──
          AnimatedBuilder(
            animation: Listenable.merge([_dropCtrl, _growCtrl]),
            builder: (_, __) {
              final top = Tween<double>(begin: -28, end: centerY).evaluate(
                CurvedAnimation(parent: _dropCtrl, curve: Curves.easeIn),
              );

              final diameter = Tween<double>(begin: 28, end: maxDiameter)
                  .evaluate(
                    CurvedAnimation(parent: _growCtrl, curve: Curves.easeInOut),
                  );

              return Positioned(
                top: top - diameter / 2,
                left: size.width / 2 - diameter / 2,
                child: Container(
                  width: diameter,
                  height: diameter,
                  decoration: const BoxDecoration(
                    color: Color(0xff6c5ce7),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),

          // ── المحتوى ──
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // اللوجو
              AnimatedBuilder(
                animation: _logoCtrl,
                builder: (_, __) => Opacity(
                  opacity: _logoOpacity.value,
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: Image.asset(
                      Assets.assetsImagesWaslaLogo,
                      width: 130,
                      height: 130,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // الحروف
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_word.length, (i) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _letterOpacity[i],
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 500),
                      offset: Offset(0, _letterY[i] / 100),
                      curve: Curves.elasticOut,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          _word[i],
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),

              // التاجلاين
              FadeTransition(
                opacity: _taglineOpacity,
                child: SlideTransition(
                  position: _taglineSlide,
                  child: Text(
                    'Connect Every Time',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
