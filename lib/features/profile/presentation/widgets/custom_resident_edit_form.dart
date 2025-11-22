import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/models/user_model.dart';
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
    return Form(
      key: cubit.residentFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            initealValue: user.fullName,
            hint: "fullName".tr(context),
            onChanged: (name) {
              cubit.fullName = name;
            },
            validator: (value) => validateName(value, context),
          ),
          VerticalSpace(height: 4),
          CustomTextFormField(
            initealValue: user.phoneNumber,
            keyboardTyp: TextInputType.phone,
            hint: "phoneNumber".tr(context),
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
            child: Image.asset(Assets.assetsImagesLocation, fit: BoxFit.cover),
          ),
          const Spacer(),
          GeneralButton(
            onPressed: () {
              context.pushScreen(AppRoutes.accountChangePassScreen);
            },
            text: "Change Password",
          ),
          VerticalSpace(height: 4),
          GeneralButton(onPressed: () {
            if(cubit.residentFormKey.currentState!.validate()){
              
            }
          }, text: "Update"),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
