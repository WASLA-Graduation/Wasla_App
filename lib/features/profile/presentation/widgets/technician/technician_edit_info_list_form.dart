import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class TechnicianEditInfoListForm extends StatelessWidget {
  const TechnicianEditInfoListForm({super.key, required this.technicianModel});
  final TechnicianModel technicianModel;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateInfoFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is ProfileUpdateInfoSuccess) {
          toastAlert(
            color: AppColors.green,
            msg: "profile_updated_success".tr(context),
          );
        }
      },
      child: Form(
        key: cubit.technicainFormKey,
        child: Column(
          spacing: 10.h,
          children: [
            CustomTextFormField(
              initealValue: technicianModel.fullName,
              withTitle: true,
              title: "fullName".tr(context),
              hint: "fullName".tr(context),
              onChanged: (name) => cubit.fullName = name,
              validator: (value) => validateSimpleData(value, context),
            ),
            CustomTextFormField(
              initealValue: technicianModel.phone,
              withTitle: true,
              title: "phoneNumber".tr(context),
              keyboardTyp: TextInputType.phone,
              hint: "phoneNumber".tr(context),
              onChanged: (phone) => cubit.phoneNumber = phone,
              validator: (value) => validatePhone2(value, context),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "address".tr(context),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                context.pushScreen(AppRoutes.authMapScreen);
              },
              child: Image.asset(
                Assets.assetsImagesLocation,
                fit: BoxFit.cover,
              ),
            ),
            CustomTextFormField(
              initealValue: technicianModel.experienceYears.toString(),
              withTitle: true,
              title: "experience".tr(context),
              keyboardTyp: TextInputType.number,
              hint: "experience".tr(context),
              onChanged: (years) => cubit.experienceYears = int.parse(years),
              validator: (value) => validateSimpleData(value, context),
            ),
            CustomTextFormField(
              initealValue: technicianModel.description,
              withTitle: true,
              title: "description".tr(context),
              onChanged: (description) => cubit.description = description,
              validator: (value) => validateSimpleData(value, context),
              minLines: 1,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
