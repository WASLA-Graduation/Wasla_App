import 'package:flutter/material.dart';

class CustomDescriptionTextWidget extends StatelessWidget {
  const CustomDescriptionTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.labelLarge);
  }
}