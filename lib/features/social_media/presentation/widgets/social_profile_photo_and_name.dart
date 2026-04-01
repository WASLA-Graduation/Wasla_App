import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/social_media/data/models/social_profile_model.dart';

class SocailProfilePhotoAndName extends StatelessWidget {
  const SocailProfilePhotoAndName({super.key, required this.profile});
  final SocialProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleNeworkImage(
            imageUrl: profile?.profilePhoto ?? "",
            isLoading: profile == null,
            size: 100,
          ),
        ),
        const SizedBox(height: 10),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            profile?.userName ?? ".....",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
