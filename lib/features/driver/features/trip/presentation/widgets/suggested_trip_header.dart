import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';

class SuggestTripHeader extends StatelessWidget {
  const SuggestTripHeader({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleNeworkImage(imageUrl: image, isLoading: false),

      title: Text(
        name,
        style: Theme.of(context).textTheme.labelMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
