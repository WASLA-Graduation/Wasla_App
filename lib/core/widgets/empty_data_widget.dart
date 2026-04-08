import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? title;
  final String? message;

  const EmptyStateWidget({super.key, this.title, this.message});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final double spacing = SizeConfig.isTablet ? 24.0 : 16.0;
    final double illustrationSize = SizeConfig.isTablet ? 200.0 : 150.0;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.isTablet ? 64.0 : 32.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmptyStateIllustration(isDark: isDark, size: illustrationSize),
            SizedBox(height: spacing),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title ?? 'No Data Found',
                textAlign: TextAlign.center,
                style: AppStyles.styleBold25(context).copyWith(
                  color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                ),
              ),
            ),
            SizedBox(height: spacing / 2),
            Text(
              message ??
                  'No items available right now,\nplease try again later',
              textAlign: TextAlign.center,
              style: AppStyles.styleMeduim17(context).copyWith(
                color: isDark
                    ? AppColors.whiteColor.withOpacity(0.55)
                    : AppColors.blackColor.withOpacity(0.45),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyStateIllustration extends StatelessWidget {
  const _EmptyStateIllustration({required this.isDark, required this.size});

  final bool isDark;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.87,
      child: CustomPaint(painter: _EmptyStatePainter(isDark: isDark)),
    );
  }
}

class _EmptyStatePainter extends CustomPainter {
  final bool isDark;

  const _EmptyStatePainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Color primaryColor = isDark
        ? const Color(0xFF4A90D9)
        : const Color(0xFF1565C0);
    final Color bgColor = isDark ? const Color(0xFF0D1B2E) : Colors.white;
    final Color screenBg = isDark
        ? const Color(0xFF101E30)
        : const Color(0xFFEEF4FF);
    final Color itemFill = isDark
        ? const Color(0xFF1A2E4A)
        : const Color(0xFFD0E4FF);
    final Color itemLine1 = isDark
        ? const Color(0xFF1E3550)
        : const Color(0xFFC0D8F8);
    final Color itemLine2 = isDark
        ? const Color(0xFF162840)
        : const Color(0xFFDDEEFF);
    final Color homeDot = isDark
        ? const Color(0xFF1A2E4A)
        : const Color(0xFFD0E4FF);
    final Color badgeBg = isDark
        ? const Color(0xFF2A2010)
        : const Color(0xFFFFF8E1);
    const Color badgeStroke = Color(0xFFF9A825);

    final strokePaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()..style = PaintingStyle.fill;

    // phone body
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.27, h * 0.08, w * 0.47, h * 0.77),
      const Radius.circular(10),
    );
    fillPaint.color = bgColor;
    canvas.drawRRect(phoneRect, fillPaint);
    canvas.drawRRect(phoneRect, strokePaint);

    // screen area
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.32, h * 0.17, w * 0.36, h * 0.55),
      const Radius.circular(4),
    );
    fillPaint.color = screenBg;
    canvas.drawRRect(screenRect, fillPaint);

    // list items
    _drawListItem(
      canvas,
      size,
      w * 0.36,
      h * 0.23,
      itemFill,
      itemLine1,
      itemLine2,
      primaryColor,
      strokePaint,
      fillPaint,
    );
    _drawListItem(
      canvas,
      size,
      w * 0.36,
      h * 0.40,
      itemFill,
      itemLine1,
      itemLine2,
      primaryColor,
      strokePaint,
      fillPaint,
    );
    _drawListItem(
      canvas,
      size,
      w * 0.36,
      h * 0.57,
      itemFill,
      itemLine1,
      itemLine2,
      primaryColor,
      strokePaint,
      fillPaint,
    );

    // X lines
    final xPaint = Paint()
      ..color = primaryColor.withOpacity(0.2)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.34, h * 0.19),
      Offset(w * 0.65, h * 0.70),
      xPaint,
    );
    canvas.drawLine(
      Offset(w * 0.65, h * 0.19),
      Offset(w * 0.34, h * 0.70),
      xPaint,
    );

    // home button
    final homePaint = Paint()
      ..color = homeDot
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.88), w * 0.04, homePaint);
    strokePaint.strokeWidth = 1.2;
    canvas.drawCircle(Offset(w * 0.5, h * 0.88), w * 0.04, strokePaint);

    // badge circle
    final badgeCenter = Offset(w * 0.83, h * 0.18);
    const double badgeRadius = 18;
    fillPaint.color = badgeBg;
    final badgeStrokePaint = Paint()
      ..color = badgeStroke
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(badgeCenter, badgeRadius, fillPaint);
    canvas.drawCircle(badgeCenter, badgeRadius, badgeStrokePaint);

    // sad face eyes
    final eyePaint = Paint()
      ..color = badgeStroke
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(badgeCenter.dx - 5, badgeCenter.dy - 4),
      2,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(badgeCenter.dx + 5, badgeCenter.dy - 4),
      2,
      eyePaint,
    );

    // sad mouth
    final mouthPaint = Paint()
      ..color = badgeStroke
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final mouthPath = Path()
      ..moveTo(badgeCenter.dx - 6, badgeCenter.dy + 7)
      ..quadraticBezierTo(
        badgeCenter.dx,
        badgeCenter.dy + 3,
        badgeCenter.dx + 6,
        badgeCenter.dy + 7,
      );
    canvas.drawPath(mouthPath, mouthPaint);
  }

  void _drawListItem(
    Canvas canvas,
    Size size,
    double x,
    double y,
    Color itemFill,
    Color line1,
    Color line2,
    Color stroke,
    Paint strokePaint,
    Paint fillPaint,
  ) {
    final double w = size.width;

    // thumbnail box
    final itemRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x, y, w * 0.11, w * 0.11),
      const Radius.circular(3),
    );
    fillPaint.color = itemFill;
    canvas.drawRRect(itemRect, fillPaint);
    strokePaint.strokeWidth = 1.2;
    strokePaint.color = stroke;
    canvas.drawRRect(itemRect, strokePaint);

    // line 1
    final line1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x + w * 0.14, y + w * 0.02, w * 0.15, w * 0.03),
      const Radius.circular(2),
    );
    fillPaint.color = line1;
    canvas.drawRRect(line1Rect, fillPaint);

    // line 2
    final line2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x + w * 0.14, y + w * 0.065, w * 0.10, w * 0.025),
      const Radius.circular(1.5),
    );
    fillPaint.color = line2;
    canvas.drawRRect(line2Rect, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _EmptyStatePainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}
