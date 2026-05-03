import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/helpers/url_helper.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_doc_text_details.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class ResidetnRestDetailsCardWidget extends StatelessWidget {
  const ResidetnRestDetailsCardWidget({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorName(context),
        Divider(height: 15, color: AppColors.primaryColor, thickness: .1),
        CustomScrollableRowData(
          value: restaurant.ownerName,
          title: "owener".tr(context),
        ),
        const SizedBox(height: 3),
        CustomScrollableRowData(
          value: restaurant.name,
          title: "restaurantName".tr(context),
        ),
        const SizedBox(height: 3),
        CustomScrollableRowData(
          onTap: () {
            UrlHelper.callPhone(restaurant.phoneNumber);
          },
          value: restaurant.phoneNumber,
          title: "phone".tr(context),
        ),
      ],
    );
  }

  Text _buildDoctorName(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      restaurant.ownerName,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
