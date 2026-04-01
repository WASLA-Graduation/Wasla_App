import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DotsLoader extends StatefulWidget {
  const DotsLoader({super.key});

  @override
  State<DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<DotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final anim = Tween<double>(begin: 0.35, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(i * 0.15, i * 0.15 + 0.4, curve: Curves.easeInOut),
          ),
        );
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(anim.value),
            ),
            transform: Matrix4.identity()..scale(0.6 + anim.value * 0.6),
            transformAlignment: Alignment.center,
          ),
        );
      }),
    );
  }
}
