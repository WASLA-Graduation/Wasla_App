import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/general_button.dart';

class GeneralConfirmDialog extends StatelessWidget {
  const GeneralConfirmDialog({
    super.key,
    this.icon,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.confirmColor = Colors.red,
    this.cancelColor = const Color(0xFFD1D5DB),
  });

  final String title;
  final String message;

  final String confirmText;
  final String cancelText;

  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  final Color confirmColor;
  final Color cancelColor;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15,
          children: [
            if (icon != null) icon!,
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GeneralButton(
                    text: cancelText,
                    color: cancelColor,
                    height: 40,
                    onPressed: () {
                      Navigator.pop(context);
                      onCancel?.call();
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GeneralButton(
                    text: confirmText,
                    color: confirmColor,
                    height: 40,
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
