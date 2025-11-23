import 'package:flutter/material.dart';

class DocServiceItemHeader extends StatelessWidget {
  const DocServiceItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "Teeth Cleaning",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(width: 20),
        Text("500  EGP", style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }
}
