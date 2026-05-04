import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/views/privacy_policy_view.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("helpCenter".tr(context))),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeDefault,
        ),

        child: HelpCenterBody(),
      ),
    );
  }
}

class HelpCenterBody extends StatelessWidget {
  HelpCenterBody({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email = '';
    String name = '';
    String message = '';
    return ListView(
      children: [
        PolicySection(
          title: 'reportAProblem'.tr(context),
          body: 'reportAProblemSubTitle'.tr(context),
        ),

        SizedBox(height: AppSizes.paddingSizeLarge),
        HelpCenterForm(
          formKey: formKey,
          nameChanged: (val) => name = val,
          emailChanged: (val) => email = val,
          messageChanged: (val) => message = val,
        ),
        SizedBox(height: AppSizes.paddingSizeLarge),

        BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is HelpCenterAddContactFailure) {
              showToast(state.errMsg, color: AppColors.error);
            } else if (state is HelpCenterAddContactSuccess) {
              showToast(
                'messageSent'.tr(context),
                color: AppColors.acceptGreen,
              );

              context.pop();
            }
          },
          builder: (context, state) {
            return GeneralButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<ProfileCubit>().addContact(
                    fullName: name,
                    email: email,
                    message: message,
                  );
                }
              },
              text:state is HelpCenterAddContactLoading ? 'sending'.tr(context) : 'sendReport'.tr(context),
            );
          },
        ),
      ],
    );
  }
}

class HelpCenterForm extends StatelessWidget {
  const HelpCenterForm({
    super.key,
    required this.formKey,
    required this.nameChanged,
    required this.emailChanged,
    required this.messageChanged,
  });

  final GlobalKey<FormState> formKey;

  final ValueChanged<String> nameChanged;
  final ValueChanged<String> emailChanged;
  final ValueChanged<String> messageChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            onChanged: nameChanged,
            withTitle: true,
            title: "fullName".tr(context),
            hint: "fullNameHint".tr(context),
            prefixIcon: const Icon(Icons.person_outline),
            validator: (val) => (val == null || val.trim().isEmpty)
                ? "fieldRequired".tr(context)
                : null,
          ),
          SizedBox(height: AppSizes.paddingSizeSmall),
          CustomTextFormField(
            onChanged: emailChanged,
            withTitle: true,
            title: "email".tr(context),
            hint: "emailHint".tr(context),
            keyboardTyp: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "fieldRequired".tr(context);
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                return "invalidEmail".tr(context);
              }
              return null;
            },
          ),
          SizedBox(height: AppSizes.paddingSizeSmall),
          CustomTextFormField(
            onChanged: messageChanged,
            withTitle: true,
            title: "messaged".tr(context),
            hint: "messageHint".tr(context),
            maxLines: 5,
            minLines: 4,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Icon(Icons.chat_bubble_outline),
            ),
            validator: (val) => (val == null || val.trim().isEmpty)
                ? "fieldRequired".tr(context)
                : null,
          ),
          SizedBox(height: AppSizes.paddingSizeDefault),
        ],
      ),
    );
  }
}
