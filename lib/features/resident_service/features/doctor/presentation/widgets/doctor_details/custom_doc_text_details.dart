import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/helpers/url_helper.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';

class CustomDoctorDetailsText extends StatelessWidget {
  const CustomDoctorDetailsText({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorName(context),
        Divider(height: 15, color: AppColors.primaryColor, thickness: .1),
        CustomScrollableRowData(
          value: doctor.hospitalname,
          title: "hospital".tr(context),
        ),
        const SizedBox(height: 3),
        CustomScrollableRowData(
          value: doctor.specialtyName,
          title: "specialty".tr(context),
        ),
        const SizedBox(height: 3),
        CustomScrollableRowData(
          value: doctor.phone,
          title: "phone".tr(context),
          onTap: () {
            UrlHelper.callPhone(doctor.phone);
          },
        ),
      ],
    );
  }

  Text _buildDoctorName(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      doctor.fullName,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class CustomTextWithColonWidget extends StatelessWidget {
  const CustomTextWithColonWidget({
    super.key,
    required this.date,
    required this.title,
  });

  final String date;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      "$title : $date",
      style: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
    );
  }
}

class CustomScrollableRowData extends StatelessWidget {
  const CustomScrollableRowData({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
  });

  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          Text(
            "$title : ",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),

          InkWell(
            onTap: onTap,
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
            ),
          ),
        ],
      ),
    );
  }
}
