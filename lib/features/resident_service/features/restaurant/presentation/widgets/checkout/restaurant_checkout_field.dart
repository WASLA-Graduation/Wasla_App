import 'package:flutter/material.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class RestaurantCheckoutField extends StatelessWidget {
  const RestaurantCheckoutField({super.key, required this.callback, required this.title});
  final ValueChanged<String> callback;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hint: title,
      withTitle: true,
      title: title,
      onChanged: callback,
    );
  }
}
