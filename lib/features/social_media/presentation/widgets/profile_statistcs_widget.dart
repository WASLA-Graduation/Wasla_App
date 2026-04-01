import 'package:flutter/material.dart';

class ProfileStaticsWidget extends StatelessWidget {
  const ProfileStaticsWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(title, style: Theme.of(context).textTheme.displaySmall),
      ],
    );
  }
}
