import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';

class ResidentProfileInfo extends StatelessWidget {
  const ResidentProfileInfo({super.key, required this.resident});

  final UserModel resident;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profileInformation'.tr(context))),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeDefault,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleNeworkImage(
              imageUrl: resident.imageUrl,
              isLoading: false,
              size: 100,
            ),

            const SizedBox(height: 20),

            /// Info Cards
            _buildInfoCard(
              context,
              icon: Icons.person,
              title: 'fullName'.tr(context),
              value: resident.fullName,
            ),

            _buildInfoCard(
              context,
              icon: Icons.email,
              title: 'email'.tr(context),
              value: resident.email,
            ),

            _buildInfoCard(
              context,
              icon: Icons.phone,
              title: 'phone'.tr(context),
              value: resident.phoneNumber,
            ),
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
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
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
}
