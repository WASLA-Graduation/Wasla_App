import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/profile/presentation/widgets/technician/techincian_edit_profile_buttons.dart';
import 'package:wasla/features/profile/presentation/widgets/technician/technician_edit_profile_listview.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class TechnicianEditProfileBody extends StatelessWidget {
  const TechnicianEditProfileBody({super.key, required this.technician});
  final TechnicianModel technician;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Expanded(
          child: TechniciaEditProfileListView(technicianModel: technician),
        ),
        TechnicainEditProfileButttons(isTablet: SizeConfig.isTablet),
        SizedBox(height: 20.h),
      ],
    );
  }
}
