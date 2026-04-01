import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class PulseSection extends StatefulWidget {
  const PulseSection({super.key});

  @override
  State<PulseSection> createState() => _PulseSectionState();
}

class _PulseSectionState extends State<PulseSection>
    with TickerProviderStateMixin {
  late AnimationController pulseController;
  late AnimationController orbitController;

  @override
  void initState() {
    super.initState();
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    pulseController.dispose();
    orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double containerSize = 200;
    const double avatarSize = 82;
    const double orbitRadius = 88;

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(3, (i) {
            final delay = i * 0.33;
            final scale = Tween<double>(begin: 0.6, end: 1.1).animate(
              CurvedAnimation(
                parent: pulseController,
                curve: Interval(delay, 1.0, curve: Curves.easeOut),
              ),
            );
            final opacity = Tween<double>(begin: 0.5, end: 0.0).animate(
              CurvedAnimation(
                parent: pulseController,
                curve: Interval(delay, 1.0, curve: Curves.easeOut),
              ),
            );
            final ringSize = containerSize - i * 24.0;
            return AnimatedBuilder(
              animation: pulseController,
              builder: (_, __) => Transform.scale(
                scale: scale.value,
                child: Opacity(
                  opacity: opacity.value,
                  child: Container(
                    width: ringSize,
                    height: ringSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor.withOpacity(
                        0.10 + i * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),

          // 3 orbiting cars
          ...List.generate(3, (i) {
            final offsetAngle = (2 * pi / 3) * i;
            return AnimatedBuilder(
              animation: orbitController,
              builder: (_, __) {
                final angle = orbitController.value * 2 * pi + offsetAngle;
                return Transform.translate(
                  offset: Offset(
                    orbitRadius * cos(angle),
                    orbitRadius * sin(angle),
                  ),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      color: AppColors.primaryColor,
                      size: 16,
                    ),
                  ),
                );
              },
            );
          }),

          // Center avatar
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.primaryColor, AppColors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.4),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(Icons.location_on, color: Colors.white, size: 38),
          ),
        ],
      ),
    );
  }
}
