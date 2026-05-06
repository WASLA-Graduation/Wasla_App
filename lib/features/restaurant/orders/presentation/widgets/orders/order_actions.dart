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
    return status == OrderStatus.paid
        ? PrepardOrCancelButton(
            onTap: onPrepard,
            label: 'markAsPrepared'.tr(context),
            isCancel: false,
          )
        : _ConfirmButton(
            label: confirmLabel ?? 'markAsDelevared'.tr(context),
            onTap: onConfirm,
          );
  }
}

class PrepardOrCancelButton extends StatelessWidget {
  const PrepardOrCancelButton({
    super.key,
    required this.onTap,
    this.isCancel,
    required this.label,
  });

  final VoidCallback onTap;

  final bool? isCancel;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: isCancel == true ? AppColors.red : AppColors.orange,
          side: BorderSide(
            color: isCancel == true ? AppColors.red : AppColors.orange,
            width: 0.5,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: Theme.of(context).textTheme.displaySmall,
        ),
        child: Text(label),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D9E75),
          foregroundColor: const Color(0xFFE1F5EE),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: Theme.of(context).textTheme.displaySmall,
        ),
        child: Text(label),
      ),
    );
  }
}
