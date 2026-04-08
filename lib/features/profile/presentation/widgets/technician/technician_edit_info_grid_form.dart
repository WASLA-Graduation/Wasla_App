import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class TechnicianEditInfoGridForm extends StatelessWidget {
  const TechnicianEditInfoGridForm({super.key, required this.technicianModel});
  final TechnicianModel technicianModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Form(
      key: cubit.technicainFormKey,
      child: Column(
        spacing: 20.h,
        children: [
          Row(
            spacing: 30.w,
            children: [
              Expanded(
                child: CustomTextFormField(
                  withTitle: true,
                  title: 'fullName'.tr(context),
                  hint: "fullName".tr(context),
                  onChanged: (name) => cubit.fullName = name,
                  validator: (value) => validateSimpleData(value, context),
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  keyboardTyp: TextInputType.phone,
                  withTitle: true,
                  title: 'phoneNumber'.tr(context),
                  hint: "phoneNumber".tr(context),
                  onChanged: (phone) => cubit.phoneNumber = phone,
                  validator: (value) => validatePhone2(value, context),
                ),
              ),
            ],
          ),
          Row(
            spacing: 30.w,
            children: [
              Expanded(
                child: CustomTextFormField(
                  withTitle: true,
                  title: 'experience'.tr(context),
                  keyboardTyp: TextInputType.number,
                  hint: "experience".tr(context),
                  onChanged: (years) =>
                      cubit.experienceYears = int.parse(years),
                  validator: (value) => validateSimpleData(value, context),
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  withTitle: true,
                  title: 'description'.tr(context),
                  hint: "description".tr(context),
                  onChanged: (description) => cubit.description = description,
                  validator: (value) => validateSimpleData(value, context),
                  minLines: 1,
                  maxLines: 5,
                ),
              ),
            ],
          ),
          TextDetailsIdentfierWidget(
            leading: "location".tr(context),
            trailing: "changeLocation".tr(context),
            onTap: () {
              context.pushScreen(AppRoutes.authMapScreen);
            },
          ),
        ],
      ),
    );
  }
}
