import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/show_date_picker.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CustomDocotorInfoForm extends StatelessWidget {
  const CustomDocotorInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.doctortInfoformKey,
      child: Column(
        children: [
          CustomTextFormField(
            hint: "fullName".tr(context),
            prefixIcon: Icon(Icons.person, color: AppColors.gray),
            onChanged: (name) => cubit.name = name,
            validator:(value) =>validateName(value, context) ,
          ),
          const VerticalSpace(height: 2),
          CustomTextFormField(
            keyboardTyp: TextInputType.number,
            hint: "phoneNumber".tr(context),
            prefixIcon: Icon(Icons.phone, color: AppColors.gray),
            onChanged: (phone) => cubit.phone = phone,
            validator: (value) =>validatePhone(value, context),
          ),
          const VerticalSpace(height: 2),
          CustomTextFormField(
            onTap: () async {
              cubit.dateController.text = await selectDate(context: context);
            },
            readOnly: true,
            controller: cubit.dateController,
            prefixIcon: const Icon(Icons.date_range),
            hint: "dateOfBirth".tr(context),
            validator: (value) =>validateDate(value, context),
          ),
          const VerticalSpace(height: 2),
          CustomTextFormField(
            readOnly: true,
            onTap: () {
              context.pushScreen(AppRoutes.authMapScreen);
            },
            controller: cubit.addressController,
            prefixIcon: const Icon(Icons.location_on),
            hint: "address".tr(context),
            validator: (value) =>validateAddress(value, context),
          ),
          const SizedBox(height: 30),
          const Spacer(),
          GeneralButton(
            text: "continue".tr(context),
            onPressed: () {
              if (cubit.doctortInfoformKey.currentState!.validate()) {
                context.pushScreen(AppRoutes.doctorCompleteInfoScreen);
              }
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
