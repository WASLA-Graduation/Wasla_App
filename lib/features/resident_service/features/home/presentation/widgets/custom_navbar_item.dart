import 'package:flutter/material.dart';

class CustomNavBarItem extends StatelessWidget {
  const CustomNavBarItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  final String name;
  final String icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Image.asset(icon, width: 25, color: color),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: color),
        ),
      ],
    );
  }
}
