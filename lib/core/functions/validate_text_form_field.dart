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



String? validateName(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return "nameRequired".tr(context);
  } else if (value.trim().length < 3) {
    return "nameTooShort".tr(context);
  } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
    return "nameLettersOnly".tr(context);
  }
  return null;
}

String? validatePhone(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return "phoneRequired".tr(context);
  } else if (!RegExp(r"^01[0-9]{9}$").hasMatch(value)) {
    return "invalidPhone".tr(context);
  }
  return null;
}

String? validateAddress(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return "addressRequired".tr(context);
  } else if (value.trim().length < 5) {
    return "addressTooShort".tr(context);
  }
  return null;
}

String? validateDate(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return "dateRequired".tr(context);
  }

  try {
    DateFormat('dd/MM/yyyy').parseStrict(value);
  } catch (e) {
    return "invalidDateFormat".tr(context);
  }

  return null;
}

String? validateSimpleData(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return "dateRequired".tr(context);
  }

  return null;
}
String? validateNationalId(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return "dateRequired".tr(context);
  }
  else if(value.length != 14){
    return "invalidNationalId".tr(context);
  }

  return null;
}
