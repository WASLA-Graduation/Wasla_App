import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';

class CustomBottomSheetConfirmWidget extends StatelessWidget {
  const CustomBottomSheetConfirmWidget({
    super.key,
    required this.title,
    required this.description,
    this.titleColor = Colors.red,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String description;

  final Color titleColor;

  final String confirmText;
  final String cancelText;

  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

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
        spacing: 13,
        children: [
          const UnderLineWidget(),
          _buildTitle(context),
          const Divider(thickness: 0.3),
          _buildDescription(context),
          const SizedBox(height: 10),
          _buildButtons(context),
        ],
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineMedium!.copyWith(color: titleColor),
    );
  }

  Text _buildDescription(BuildContext context) {
    return Text(
      description,
      style: Theme.of(
        context,
      ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w900),
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GeneralButton(
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            text: cancelText,
            height: 45,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: GeneralButton(
            onPressed: onConfirm,
            text: confirmText,
            height: 45,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
