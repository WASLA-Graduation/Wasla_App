import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class RestaurantProfileInfo extends StatelessWidget {
  const RestaurantProfileInfo({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('aboutRestaurant'.tr(context))),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeDefault,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// IMAGE
            CircleNeworkImage(
              imageUrl: restaurant.profile,
              isLoading: false,
              size: 110,
            ),

            const SizedBox(height: 20),

            _buildSectionTitle("basicInfo".tr(context)),
            _buildInfoCard(
              context,
              icon: Icons.restaurant,
              title: "name".tr(context),
              value: restaurant.name,
            ),
            _buildInfoCard(
              context,
              icon: Icons.category,
              title: "category".tr(context),
              value: restaurant.restaurantCategoryName,
            ),
            _buildInfoCard(
              context,
              icon: Icons.person,
              title: "ownerName".tr(context),
              value: restaurant.ownerName,
            ),

            
            _buildSectionTitle("contact".tr(context)),
            _buildInfoCard(
              context,
              icon: Icons.email,
              title: "email".tr(context),
              value: restaurant.email,
            ),
            _buildInfoCard(
              context,
              icon: Icons.phone,
              title: "phone".tr(context),
              value: restaurant.phoneNumber,
            ),

            /// DESCRIPTION
            _buildDescriptionCard(context),

            /// GALLERY
            _buildGallery(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isEmpty ? "-" : value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "description".tr(context),
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 6),
          Text(
            restaurant.description.isEmpty
                ? "-"
                : restaurant.description,
          ),
        ],
      ),
    );
  }

  Widget _buildGallery(BuildContext context) {
    if (restaurant.gallery.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("restaurantGalary".tr(context)),

        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: restaurant.gallery.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  restaurant.gallery[index],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}