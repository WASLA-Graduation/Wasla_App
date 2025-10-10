import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CustomAuthForm extends StatelessWidget {
  const CustomAuthForm({super.key, required this.formKey});
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                hint: "email".tr(context),
                prefixIcon: Icon(
                  Icons.email,
                  color: AppColors.gray,
                ),
                onChanged: (email) => cubit.email = email,
                validator: (value) => validateEmail(context, value),
              ),
              const VerticalSpace(height: 3),
              CustomTextFormField(
                hint: "password".tr(context),
                prefixIcon: Icon(
                  Icons.lock,
                  color: AppColors.gray,
                ),
                onChanged: (pass) => cubit.password = pass,
                validator: (value) => validatePassword(context, value),
                isSecure: !cubit.isPasswordVisible,
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
            ],
          ),
        );
      },
    );
  }
}
