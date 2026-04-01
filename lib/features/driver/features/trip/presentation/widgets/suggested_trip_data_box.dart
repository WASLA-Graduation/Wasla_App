import 'package:flutter/material.dart';

class SuggestedTripBoxData extends StatelessWidget {
  const SuggestedTripBoxData({
    super.key,
    required this.title,
    required this.data,
  });
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(data, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}