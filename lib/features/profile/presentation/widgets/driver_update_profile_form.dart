import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class DriverUpdateProfileForm extends StatelessWidget {
  const DriverUpdateProfileForm({super.key, required this.driver});
  final DriverProfileModel driver;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Form(
      key: context.read<ProfileCubit>().driverFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            withTitle: true,
            title: "full_name".tr(context),
            initealValue: driver.fullName,
            hint: "fullName".tr(context),
            onChanged: (name) => cubit.fullName = name,
            validator: (value) => validateSimpleData(value, context),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            withTitle: true,
            title: "phoneNumber".tr(context),
            initealValue: driver.phone,
            hint: "phoneNumber".tr(context),
            onChanged: (phone) => cubit.phoneNumber = phone,
            validator: (value) => validatePhone2(value, context),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            withTitle: true,
            title: "experience".tr(context),
            initealValue: driver.drivingExperienceYears.toString(),
            keyboardTyp: TextInputType.number,
            hint: "experience".tr(context),
            onChanged: (years) => cubit.experienceYears = int.parse(years),
            validator: (value) => validateSimpleData(value, context),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            withTitle: true,
            title: "vechileModel".tr(context),
            initealValue: '2026',
            hint: "vechileModel".tr(context),
            onChanged: (model) => cubit.vehicleModel = model,
            validator: (value) => validateSimpleData(value, context),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            withTitle: true,
            title: "vechileNumber".tr(context),
            initealValue: driver.vehicleNumber.toString(),
            keyboardTyp: TextInputType.number,
            hint: "vechileNumber".tr(context),
            onChanged: (number) => cubit.vehicleNumber = number,
            validator: (value) => validateCarNum(value, context),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            withTitle: true,
            title: "description".tr(context),
            initealValue: driver.description,
            hint: "description".tr(context),
            onChanged: (description) => cubit.description = description,
            validator: (value) => validateSimpleData(value, context),
            minLines: 1,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
