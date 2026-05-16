import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';

class DriverProfileInfoPage extends StatelessWidget {
  final DriverProfileModel driver;

  const DriverProfileInfoPage({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'personalInformation'.tr(context),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeDefault,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleNeworkImage(
              imageUrl: driver.profilePhoto,
              isLoading: false,
              size: 110,
            ),

            const SizedBox(height: 20),

            _buildInfoCard(
              context,
              icon: Icons.person,
              title: 'full_name'.tr(context),
              value: driver.fullName,
            ),

            _buildInfoCard(
              context,
              icon: Icons.email,
              title: 'email'.tr(context),
              value: driver.email,
            ),

            _buildInfoCard(
              context,
              icon: Icons.phone,
              title: 'phone'.tr(context),
              value: driver.phone,
            ),

            _buildInfoCard(
              context,
              icon: Icons.cake,
              title: 'dateOfBirth'.tr(context),
              value: driver.birthDay,
            ),

            _buildInfoCard(
              context,
              icon: Icons.directions_car,
              title: 'vechileNumber'.tr(context),
              value: driver.vehicleNumber,
            ),

            _buildInfoCard(
              context,
              icon: Icons.local_taxi,
              title: 'vechileType'.tr(context),
              value: VehicleType.getTitle(
                driver.vehicleType,
              ).tr(context),
            ),

            _buildInfoCard(
              context,
              icon: Icons.work,
              title: 'experience'.tr(context),
              value:
                  "${driver.drivingExperienceYears} ${'years'.tr(context)}",
            ),

            _buildInfoCard(
              context,
              icon: Icons.route,
              title: 'totalTrips'.tr(context),
              value: driver.tripsCount.toString(),
            ),

            _buildInfoCard(
              context,
              icon: Icons.star,
              title: 'rating'.tr(context),
              value: driver.rate.toStringAsFixed(1),
            ),

            _buildInfoCard(
              context,
              icon: Icons.wifi_tethering,
              title: 'status'.tr(context),
              value: driver.status.tr(context),
            ),

            _buildDescriptionCard(context),
          ],
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value.isEmpty ? "-" : value,
                  style: Theme.of(context).textTheme.headlineSmall,
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'description'.tr(context),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(
                context,
              ).textTheme.labelSmall?.color?.withOpacity(0.6),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            driver.description.isEmpty ? "-" : driver.description,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}