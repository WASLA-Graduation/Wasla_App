import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';

Future<String> selectDate({required BuildContext context}) async {
  final locale = context.read<GlobalCubit>().locale;

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    locale: locale,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return _getThemeOfDateDialog(context, child);
    },
  );

  if (pickedDate != null) {
    return DateFormat('dd/MM/yyyy').format(pickedDate);
  } else {
    return '';
  }
}

Theme _getThemeOfDateDialog(BuildContext context, Widget? child) {
  return Theme(
      data: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
          labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            foregroundColor: WidgetStatePropertyAll(Colors.deepPurple),
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: child!,
        ),
      ),
    );
}
