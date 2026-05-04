import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/home/data/models/bannar_model.dart';

class CustomBannarItem extends StatelessWidget {
  const CustomBannarItem({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: SizeConfig.screenWidth / 2.5,
          child: Padding(
            padding: context.isArabic
                ? const EdgeInsets.only(right: 20)
                : const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    banner.title,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    banner.subtitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  banner.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          width: 200,
          height: 170,
          right: context.isArabic ? null : -30,
          left: context.isArabic ? -30 : null,
          child: Image.asset(banner.image, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
