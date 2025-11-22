import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/models/user_model.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class CustomResidetnEditInfoForm extends StatelessWidget {
  const CustomResidetnEditInfoForm({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileResidentUpdateInfoFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is ProfileResidentUpdateInfoSuccess) {
          toastAlert(
            color: AppColors.green,
            msg: "profile_updated_success".tr(context),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: cubit.residentFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                initealValue: user.fullName,
                hint: "full_name".tr(context),
                onChanged: (name) {
                  cubit.fullName = name;
                },
                validator: (value) => validateName(value, context),
              ),
              VerticalSpace(height: 4),

              CustomTextFormField(
                initealValue: user.phoneNumber,
                keyboardTyp: TextInputType.phone,
                hint: "phone_number".tr(context),
                onChanged: (phone) {
                  cubit.phoneNumber = phone;
                },
                validator: (value) => validatePhone(value, context),
              ),
              VerticalSpace(height: 4),

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "address".tr(context),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              VerticalSpace(height: 2),

              InkWell(
                onTap: () {
                  context.pushScreen(AppRoutes.authMapScreen);
                },
                child: Image.asset(
                  Assets.assetsImagesLocation,
                  fit: BoxFit.cover,
                ),
              ),

              const Spacer(),

              GeneralButton(
                onPressed: () {
                  context.pushScreen(AppRoutes.accountChangePassScreen);
                },
                text: "change_password".tr(context),
              ),

              VerticalSpace(height: 4),

              GeneralButton(
                onPressed: () {
                  if (cubit.residentFormKey.currentState!.validate()) {
                    cubit.updateResidentInfo();
                  }
                },
                text: state is ProfileResidentUpdateInfoLoading
                    ? "loading".tr(context)
                    : "update".tr(context),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
