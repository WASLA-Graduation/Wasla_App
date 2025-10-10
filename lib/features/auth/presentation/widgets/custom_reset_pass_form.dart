import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_done_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_lable_add_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CustomResetPassForm extends StatelessWidget {
  const CustomResetPassForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.resetPassformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: CustomLableAddressWidget(
                  text: "Create Your New Password",
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hint: "Password",
                isSecure: !cubit.isPasswordVisible,
                onChanged: (pass) {
                  cubit.password = pass;
                },
                validator: validatePassword,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: cubit.togglePassIcon,
                  icon: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.gray,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                hint: "Confirm Password",
                isSecure: !cubit.isPasswordVisible,
                onChanged: (pass) {
                  cubit.confirmPassword = pass;
                },
                validator: validatePassword,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: cubit.togglePassIcon,
                  icon: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.gray,
                  ),
                ),
              ),
              VerticalSpace(height: 6),
              GeneralButton(
                onPressed: () {
                  if (cubit.resetPassformKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDoneWidget(),
                    );
                  }
                },
                text: "Save Password",
              ),
            ],
          ),
        );
      },
    );
  }
}
