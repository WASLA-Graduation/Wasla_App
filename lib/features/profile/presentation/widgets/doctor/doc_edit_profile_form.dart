import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class DoctorEditProfileForm extends StatelessWidget {
  const DoctorEditProfileForm({
    super.key,
    required this.doctor,
    required this.cubit,
  });

  final DoctorModel doctor;
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<ProfileCubit>().doctorEditKey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return CustomDropDownMenu(
                items: cubit.doctorSpecialization
                    .map(
                      (specialization) => DropDownItem(
                        label: specialization.specialization,
                        value: specialization.id.toString(),
                      ),
                    )
                    .toList(),
                hint: 'selectYourSpecialty'.tr(context),
                onSelecte: (value) {
                  cubit.specializationId = value == null ? -1 : int.parse(value);
                },
              );
            },
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            withTitle: true,
            title: "fullName".tr(context),
            initealValue: doctor.fullName,
            hint: "fullName".tr(context),
            onChanged: (name) => cubit.fullName = name,
            validator: (value) => validateName(value, context),
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            withTitle: true,
            title: "phoneNumber".tr(context),
            initealValue: doctor.phone,
            keyboardTyp: TextInputType.number,
            hint: "phoneNumber".tr(context),
            onChanged: (phone) => cubit.phoneNumber = phone,
            validator: (value) => validatePhone(value, context),
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            withTitle: true,
            title: "experience".tr(context),
            initealValue: doctor.experienceYears.toString(),
            keyboardTyp: TextInputType.number,
            hint: "experience".tr(context),
            onChanged: (years) => cubit.experience = int.parse(years),
            validator: (value) => validateSimpleData(value, context),
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            withTitle: true,
            title: "universityName".tr(context),
            initealValue: doctor.universityName,
            hint: "universityName".tr(context),
            onChanged: (universtiy) => cubit.universtiyName = universtiy,
            validator: (value) => validateSimpleData(value, context),
          ),
          const SizedBox(height: 12),
      
          CustomTextFormField(
            initealValue: doctor.hospitalname,
            withTitle: true,
            title: "hostpitalName".tr(context),
            hint: "hostpitalName".tr(context),
            onChanged: (hospital) => cubit.hospitalName = hospital,
            validator: (value) => validateSimpleData(value, context),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "address".tr(context),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              context.pushScreen(AppRoutes.authMapScreen);
            },
            child: Image.asset(Assets.assetsImagesLocation, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
