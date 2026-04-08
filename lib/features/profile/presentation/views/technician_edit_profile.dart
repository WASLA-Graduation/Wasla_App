import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/profile/presentation/widgets/technician/technicia_edit_profile_body.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class TechnicianEditProfile extends StatelessWidget {
  const TechnicianEditProfile({super.key, required this.technician});
  final TechnicianModel technician;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("edit_profile".tr(context)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: TechnicianEditProfileBody(technician: technician),
      ),
    );
  }
}
