import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/show_date_picker.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class TechnicianInfoGridForm extends StatelessWidget {
  const TechnicianInfoGridForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.technicantInfoformKey,
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
                  onChanged: (name) => cubit.name = name,
                  validator: (value) => validateSimpleData(value, context),
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  keyboardTyp: TextInputType.phone,
                  withTitle: true,
                  title: 'phoneNumber'.tr(context),
                  hint: "phoneNumber".tr(context),
                  onChanged: (phone) => cubit.phone = phone,
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
                  title: 'address'.tr(context),
                  readOnly: true,
                  onTap: () {
                    context.pushScreen(AppRoutes.authMapScreen);
                  },
                  controller: cubit.addressController,
                  prefixIcon: const Icon(Icons.location_on),
                  hint: "address".tr(context),
                  validator: (value) => validateAddress(value, context),
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  withTitle: true,
                  title: 'dateOfBirth'.tr(context),
                  onTap: () async {
                    cubit.dateController.text = await selectDate(
                      context: context,
                    );
                  },
                  readOnly: true,
                  controller: cubit.dateController,
                  prefixIcon: Icon(Icons.date_range),
                  hint: "dateOfBirth".tr(context),
                  validator: (value) => validateDate(value, context),
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
                  onChanged: (years) => cubit.experienceYears = years,
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
        ],
      ),
    );
  }
}
