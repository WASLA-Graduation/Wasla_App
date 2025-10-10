import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

String? validateEmail(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return 'email_required'.tr(context);
  }

  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'email_invalid'.tr(context);
  }

  return null;
}

String? validatePassword(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return 'password_required'.tr(context);
  }

  if (value.length < 6) {
    return 'password_short'.tr(context);
  }

  return null;
}
