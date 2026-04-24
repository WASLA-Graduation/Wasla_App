import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

class OrderActions extends StatelessWidget {
  const OrderActions({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    this.confirmLabel,
  });

  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  final String? confirmLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _CancelButton(onTap: onCancel)),
        const SizedBox(width: 10),
        Expanded(
          child: _ConfirmButton(
            label: confirmLabel ?? 'markAsReady'.tr(context),
            onTap: onConfirm,
          ),
        ),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFE24B4A),
        side: const BorderSide(color: Color(0xFFE24B4A), width: 0.5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: Theme.of(context).textTheme.displaySmall,
      ),
      child: Text('cancelOrder'.tr(context)),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1D9E75),
        foregroundColor: const Color(0xFFE1F5EE),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: Theme.of(context).textTheme.displaySmall,
      ),
      child: Text(label),
    );
  }
}
