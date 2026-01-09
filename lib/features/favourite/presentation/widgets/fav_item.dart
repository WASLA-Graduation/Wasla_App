import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/favourite/data/models/service_provider_fav_model.dart';

class FavItem extends StatelessWidget {
  const FavItem({super.key, required this.serviceProviderModel});
  final ServiceProviderModel serviceProviderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDocImage(),
            const SizedBox(width: 18),
            Expanded(
              child: CustomFavItemDataWidget(
                serviceProviderModel: serviceProviderModel,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AspectRatio _buildDocImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        // width: 90,
        // height: 90,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.gray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),

          // image: DecorationImage(image: AssetImage(Assets.assetsImagesOnboardingTwo)),
        ),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: 112,
              height: 112,
              child: CustomCachedNetworkImage(
                imageUrl: serviceProviderModel.serviceProviderProfilePhoto,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFavItemDataWidget extends StatelessWidget {
  const CustomFavItemDataWidget({
    super.key,
    required this.serviceProviderModel,
  });
  final ServiceProviderModel serviceProviderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        Divider(height: 20, color: AppColors.primaryColor, thickness: .1),
        _buildSpecialityWidget(context),
        const SizedBox(height: 10),
        _buildReviwesWidget(context),
      ],
    );
  }

  Text _buildSpecialityWidget(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.clip,
      serviceProviderModel.serviceProviderType,
      style: Theme.of(
        context,
      ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
    );
  }

  Row _buildTitleWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            serviceProviderModel.serviceProviderName,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          Assets.assetsImagesFavourite,
          color: AppColors.primaryColor,
          height: 20,
        ),
      ],
    );
  }

  Row _buildReviwesWidget(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.primaryColor, size: 18),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "4.5  (4,577 reviwes)",
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
      ],
    );
  }
}
