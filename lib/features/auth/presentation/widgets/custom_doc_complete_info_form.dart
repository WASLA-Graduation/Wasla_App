import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/certificate_uploade_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CustomDoctorCompleteInfoForm extends StatelessWidget {
  const CustomDoctorCompleteInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.doctorCompletetInfoformKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          BlocBuilder<AuthCubit, AuthState>(
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
                  cubit.spacializationID = value == null
                      ? null
                      : int.parse(value);
                },
              );
            },
          ),
          const VerticalSpace(height: 2),
          CertificateUploadButton(),
          const VerticalSpace(height: 2),
          CustomTextFormField(
            keyboardTyp: TextInputType.number,
            hint: "experience".tr(context),
            onChanged: (years) => cubit.experienceYears = years,
            validator: (value) => validateSimpleData(value, context),
          ),
          const VerticalSpace(height: 2),
          CustomTextFormField(
            keyboardTyp: TextInputType.number,
            hint: "graduationYear".tr(context),
            onChanged: (graduationYear) =>
                cubit.graduationYear = double.parse(graduationYear),
            validator: (value) => validateNationalGraduation(value, context),
          ),
          const VerticalSpace(height: 2),
          CustomTextFormField(
            hint: "universityName".tr(context),
            onChanged: (universtiy) => cubit.universtiyName = universtiy,
            validator: (value) => validateSimpleData(value, context),
          ),
          const VerticalSpace(height: 2),
          CustomTextFormField(
            hint: "descriptionAboutYou".tr(context),
            onChanged: (description) => cubit.description = description,
            validator: (value) => validateSimpleData(value, context),
            maxLines: 5,
          ),
          const VerticalSpace(height: 2),
          Spacer(),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return GeneralButton(
                onPressed: () async {
                  if (cubit.doctorCompletetInfoformKey.currentState!
                      .validate()) {
                    await cubit.doctorCompleteInfo();
                  }
                },
                text: state is AuthDoctorCompleteInfoLoading
                    ? "sending".tr(context)
                    : "save".tr(context),
              );
            },
          ),
        ],
      ),
    );
  }
}
