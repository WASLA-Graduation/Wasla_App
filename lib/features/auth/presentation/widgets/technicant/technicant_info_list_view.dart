import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technicant_info_form.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technicant_info_image_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technicant_info_select_specializaton.dart';
import 'package:wasla/features/auth/presentation/widgets/technicant/technician_grid_info_form.dart';

class TechnicantInfoListView extends StatelessWidget {
  const TechnicantInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        TechnicantInfoImageWidget(),
        SizedBox(height: 20.h),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > SizeConfig.mobileBreakpoint) {
              return const TechnicianInfoTablet();
            } else {
              return const TechnicianInfoMobile();
            }
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class TechnicianInfoMobile extends StatelessWidget {
  const TechnicianInfoMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TechnicantCompleteInfoForm(),
        SizedBox(height: 20.h),
        TechnicantInfoSelectSpecialization(isTablet: false),
      ],
    );
  }
}

class TechnicianInfoTablet extends StatelessWidget {
  const TechnicianInfoTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        const TechnicianInfoGridForm(),
        SizedBox(height: 20.h),
        const TechnicantInfoSelectSpecialization(isTablet: true),
      ],
    );
  }
}
