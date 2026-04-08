import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/profile/presentation/widgets/technician/technician_edit_info_grid_form.dart';
import 'package:wasla/features/profile/presentation/widgets/technician/technician_edit_info_list_form.dart';
import 'package:wasla/features/profile/presentation/widgets/technician/technician_edit_specialization_select.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class TechniciaEditProfileListView extends StatelessWidget {
  const TechniciaEditProfileListView({
    super.key,
    required this.technicianModel,
  });
  final TechnicianModel technicianModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizeConfig.isMobile
            ? TechnicianEditProfileMobile(technicianModel: technicianModel)
            : TechnicianEditProfileTablet(technicianModel: technicianModel),

        SizedBox(height: 20.h),
      ],
    );
  }
}

class TechnicianEditProfileMobile extends StatelessWidget {
  const TechnicianEditProfileMobile({super.key, required this.technicianModel});

  final TechnicianModel technicianModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TechnicianEditInfoListForm(technicianModel: technicianModel),
        SizedBox(height: 20.h),
        TechnicianEditSpecializationSelect(
          isTablet: false,
          selectedSpecialization: technicianModel.specialty,
        ),
      ],
    );
  }
}

class TechnicianEditProfileTablet extends StatelessWidget {
  const TechnicianEditProfileTablet({super.key, required this.technicianModel});
  final TechnicianModel technicianModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        TechnicianEditInfoGridForm(technicianModel: technicianModel),
        SizedBox(height: 20.h),
        TechnicianEditSpecializationSelect(
          isTablet: true,
          selectedSpecialization: technicianModel.specialty,
        ),
        //
      ],
    );
  }
}
