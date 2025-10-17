import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/show_date_picker.dart';
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
            onChanged: (name) {},
            validator: (value) {},
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            prefixIcon: Icon(Icons.person),
            hint: "Nake Name",
            onChanged: (nakeName) {},
            validator: (value) {},
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            onTap: () async {
              cubit.residentDateController.text = await selectDate(
                context: context,
              );
            },
            readOnly: true,
            controller: cubit.residentDateController,
            prefixIcon: Icon(Icons.date_range),
            hint: "Date Of Birth",
            onChanged: (date) {},
            validator: (value) {},
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            keyboardTyp: TextInputType.phone,
            prefixIcon: Icon(Icons.phone),
            hint: "Phone Number",
            onChanged: (phone) {},
            validator: (value) {},
          ),
          VerticalSpace(height: 2),
          CustomTextFormField(
            readOnly: true,
            onTap: () {},
            controller: cubit.residentAddressController,
            prefixIcon: Icon(Icons.location_on),
            hint: "Address",
            onChanged: (address) {},
            validator: (value) {},
          ),
          VerticalSpace(height: 3),
          GeneralButton(text: "Continue", onPressed: () {}),
        ],
      ),
    );
  }
}
