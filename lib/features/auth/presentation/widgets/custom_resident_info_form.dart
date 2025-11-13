import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/show_date_picker.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CustomResidentInfoForm extends StatelessWidget {
  const CustomResidentInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.residentInfoformKey,
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: Icon(Icons.person),
            hint: "fullName".tr(context),
            onChanged: (name) {
              cubit.name = name;
            },
            validator: (value) => validateName(value, context),
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            prefixIcon: Icon(Icons.perm_identity_outlined),
            hint: "nationalId".tr(context),
            onChanged: (id) {
              cubit.nationalId = id;
            },
            validator: (value) => validateNationalId(value, context),
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            onTap: () async {
              cubit.dateController.text = await selectDate(context: context);
            },
            readOnly: true,
            controller: cubit.dateController,
            prefixIcon: Icon(Icons.date_range),
            hint: "dateOfBirth".tr(context),
            validator: (value) => validateDate(value, context),
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            keyboardTyp: TextInputType.phone,
            prefixIcon: Icon(Icons.phone),
            hint: "phoneNumber".tr(context),
            onChanged: (phone) {
              cubit.phone = phone;
            },
            validator: (value) => validatePhone(value, context),
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            readOnly: true,
            onTap: () {
              context.pushScreen(AppRoutes.authMapScreen);
            },
            controller: cubit.addressController,
            prefixIcon: Icon(Icons.location_on),
            hint: "address".tr(context),
            validator: (value) => validateAddress(value, context),
          ),
          Spacer(),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return GeneralButton(
                text: state is AuthResidentCompleteInfoLoading
                    ? "sending".tr(context)
                    : "continue".tr(context),
                onPressed: () async {
                  if (cubit.residentInfoformKey.currentState!.validate()) {
                    await cubit.residentCompleteInfo();
                  }
                },
              );
            },
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
