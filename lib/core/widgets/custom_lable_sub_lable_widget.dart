// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomLableSubLableWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? color;
  const CustomLableSubLableWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: color != null
                ? Theme.of(context).textTheme.labelLarge!.copyWith(color: color)
                : Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SizedBox(height: 5),
        Text(
          textAlign: TextAlign.center,
          subTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
