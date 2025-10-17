import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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


String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Name is required';
  } else if (value.trim().length < 3) {
    return 'Name must be at least 3 characters';
  } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
    return 'Name can only contain letters';
  }
  return null;
}


String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Phone number is required';
  } else if (!RegExp(r"^01[0-9]{9}$").hasMatch(value)) {
    return 'Invalid phone number';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Address is required';
  } else if (value.trim().length < 5) {
    return 'Address must be at least 5 characters';
  }
  return null;
}

String? validateDate(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Date is required';
  }

  try {
    DateFormat('dd/MM/yyyy').parseStrict(value);
  } catch (e) {
    return 'Invalid date format';
  }

  return null;
}
