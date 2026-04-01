import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';

class GlowDot extends StatelessWidget {
  final Color color;
  final Color? glowColor;

  const GlowDot({super.key, required this.color, this.glowColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: glowColor ?? color.withOpacity(0.25),
            blurRadius: 0,
            spreadRadius: 3,
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD1D5DB)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + 4), paint);
      y += 8;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class TripPoint extends StatelessWidget {
  final String label;
  final String value;

  const TripPoint({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF1B2E4B),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class TripInfoCard extends StatelessWidget {
  final String originLabel;
  final String originValue;
  final String destinationLabel;
  final String destinationValue;

  const TripInfoCard({
    super.key,
    this.originLabel = "نقطة الانطلاق",
    this.originValue = 'شارع التحرير، القاهرة',
    this.destinationLabel = 'الوجهة',
    this.destinationValue = 'مطار القاهرة الدولي',
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentDriverCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icons column
            Column(
              children: [
                const SizedBox(height: 3),
                const GlowDot(color: Color(0xFF34C759)),
                SizedBox(
                  width: 2,
                  height: 34,
                  child: CustomPaint(painter: DashedLinePainter()),
                ),
                GlowDot(
                  color: const Color(0xFFEF4444),
                  glowColor: const Color(0xFFEF4444).withOpacity(0.15),
                ),
              ],
            ),
            const SizedBox(width: 14),
            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripPoint(
                    label: 'startPoint'.tr(context),
                    value: cubit.fromPlace!.name,
                  ),
                  const SizedBox(height: 16),
                  TripPoint(
                    label: 'distination'.tr(context),
                    value: cubit.toPlace!.name,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
