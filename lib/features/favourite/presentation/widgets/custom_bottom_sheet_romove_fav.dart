import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';

class CustomConfirmBottomSheetRemoveFromFav extends StatelessWidget {
  const CustomConfirmBottomSheetRemoveFromFav({
    super.key,
    required this.title,
    required this.onConfirm,
    this.onCancel,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.content,
  });

  final String title;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UnderLineWidget(),
          const SizedBox(height: 15),

          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          if (content != null) content!,

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: GeneralButton(
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel!();
                    } else {
                      context.popScreen();
                    }
                  },
                  text: cancelText,
                  height: 45,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GeneralButton(
                  onPressed: () {
                    onConfirm();
                    context.popScreen();
                  },
                  text: confirmText,
                  height: 45,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
