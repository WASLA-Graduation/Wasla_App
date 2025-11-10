import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/certificate_uploade_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CompleteInfoBody extends StatelessWidget {
  const CompleteInfoBody({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {},
      child: Form(
        key: cubit.doctorCompletetInfoformKey,
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomDropDownMenu(
              items: items,
              hint: 'selectYourSpecialty'.tr(context),
              onSelecte: (value) {
                cubit.speciality = value ?? '';
              },
            ),
            const VerticalSpace(height: 2),
            CertificateUploadButton(),
            const VerticalSpace(height: 2),
            CustomTextFormField(
              hint: "experience".tr(context),
              prefixIcon: Icon(Icons.work, color: AppColors.gray),
              onChanged: (years) => cubit.experienceYears = years,
              validator: (value) =>validateDate(value, context),
            ),
            const VerticalSpace(height: 2),
            CustomTextFormField(
              hint: "descriptionAboutYou".tr(context),
              onChanged: (years) => cubit.name = years,
              validator: (value) =>validateDate(value, context),
              maxLines: 5,
            ),
            const VerticalSpace(height: 2),

            Spacer(),
            GeneralButton(
              onPressed: () {
                if (cubit.doctorCompletetInfoformKey.currentState!
                    .validate()) {}
              },
              text: "save".tr(context),
            ),
          ],
        ),
      ),
    );
  }
}
