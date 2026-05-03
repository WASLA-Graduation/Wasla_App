import 'package:flutter/material.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_event_model.dart';

class UserEventItem extends StatelessWidget {
  final UserEventModel userEvent;
  const UserEventItem({super.key, required this.userEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.gray.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        spacing: AppSizes.paddingSizeEight,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: CustomCachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: ApiEndPoints.imageBaseUrl + userEvent.image,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    userEvent.name,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    userEvent.description,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.star, color: AppColors.primaryColor, size: 18),
                      Text(userEvent.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
