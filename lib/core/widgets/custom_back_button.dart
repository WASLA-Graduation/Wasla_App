import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          context.popScreen();
        },
        icon: Icon(Icons.arrow_back_outlined, size: 25),
      ),
    );
  }
}