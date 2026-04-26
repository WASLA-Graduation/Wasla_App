import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/utils/app_colors.dart';

class OrderActions extends StatelessWidget {
  const OrderActions({
    super.key,
    required this.onPrepard,
    required this.onConfirm,
    this.confirmLabel,
    required this.status,
  });

  final VoidCallback onPrepard;
  final VoidCallback onConfirm;
  final OrderStatus status;

  final String? confirmLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: status == OrderStatus.pending,
          child: Expanded(
            child: Row(
              children: [
                Expanded(child: _PrepardlButton(onTap: onPrepard)),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
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

class _PrepardlButton extends StatelessWidget {
  const _PrepardlButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.orange,
        side: BorderSide(color: AppColors.orange, width: 0.5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: Theme.of(context).textTheme.displaySmall,
      ),
      child: Text('markAsPrepared'.tr(context)),
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
