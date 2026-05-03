import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_image_with_stack.dart';
import 'package:wasla/features/resident_service/features/home/data/models/service_provieders_search_model.dart';

class ResidentSearchItem extends StatelessWidget {
  const ResidentSearchItem({super.key, required this.serviceProviderModel});
  final ServiceProviedersSearchModel serviceProviderModel;

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
            BuildImageWithStackWidget(imageUrl: serviceProviderModel.photo),
            const SizedBox(width: 18),
            Expanded(
              child: CustomSearchItemData(
                serviceProviderModel: serviceProviderModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchItemData extends StatelessWidget {
  const CustomSearchItemData({super.key, required this.serviceProviderModel});
  final ServiceProviedersSearchModel serviceProviderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        Divider(height: 14, color: AppColors.primaryColor, thickness: .1),
        _buildSpecialityWidget(context),
        const SizedBox(height: 5),
        _buildDescWidget(context),
        const SizedBox(height: 5),
        _buildReviwesWidget(context),
      ],
    );
  }

  Text _buildSpecialityWidget(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.clip,
      serviceProviderModel.name,
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
            serviceProviderModel.role,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
      ],
    );
  }

  Widget _buildDescWidget(BuildContext context) {
    return Flexible(
      child: Text(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        serviceProviderModel.description,
        style: Theme.of(
          context,
        ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
      ),
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
            serviceProviderModel.rating.toString(),
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
      ],
    );
  }
}
