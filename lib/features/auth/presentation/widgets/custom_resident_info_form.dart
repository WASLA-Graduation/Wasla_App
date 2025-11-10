import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            hint: "Full Name",
            onChanged: (name) {
              cubit.name = name;
            },
            validator: validateName,
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            prefixIcon: Icon(Icons.person),
            hint: "Nake Name",
            onChanged: (nakeName) {
              cubit.nakeName = nakeName;
            },
            validator: validateName,
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            onTap: () async {
              cubit.dateController.text = await selectDate(context: context);
            },
            readOnly: true,
            controller: cubit.dateController,
            prefixIcon: Icon(Icons.date_range),
            hint: "Date Of Birth",
            validator: validateDate,
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            keyboardTyp: TextInputType.phone,
            prefixIcon: Icon(Icons.phone),
            hint: "Phone Number",
            onChanged: (phone) {
              cubit.phone = phone;
            },
            validator: validatePhone,
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            readOnly: true,
            onTap: () {
              context.pushScreen(AppRoutes.authMapScreen);
            },
            controller: cubit.addressController,
            prefixIcon: Icon(Icons.location_on),
            hint: "Address",
            validator: validateAddress,
          ),
          Spacer(),
          GeneralButton(
            text: "Continue",
            onPressed: () {
              if (cubit.residentInfoformKey.currentState!.validate()) {}
            },
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
