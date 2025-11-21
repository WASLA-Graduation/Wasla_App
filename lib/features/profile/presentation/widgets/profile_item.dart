import 'package:flutter/material.dart';
import 'package:wasla/features/profile/data/models/profile_item_model.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.profileItemModel, this.trailing});
  final ProfileItemModel profileItemModel;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            profileItemModel.image,
            height: 24,
            width: 24,
            color: Colors.black,
          ),
          const SizedBox(width: 16),
          Text(
            profileItemModel.title,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          trailing ??
          Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
        ],
      ),
    );
  }
}
