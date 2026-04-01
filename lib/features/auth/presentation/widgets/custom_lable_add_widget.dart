import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';

class CustomLableAddressWidget extends StatelessWidget {
  const CustomLableAddressWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        fontSize: SizeConfig.blockHeight * 2.1,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
