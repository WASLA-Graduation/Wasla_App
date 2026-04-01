import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/widgets/choose_many_images.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class GymCompleteInfoForm extends StatelessWidget {
  const GymCompleteInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.gymInfoformKey,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          CustomTextFormField(
            hint: "gymName".tr(context),
            onChanged: (gymName) => cubit.gymName = gymName,
            validator: (value) => validateSimpleData(value, context),
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            hint: "gymOwnerName".tr(context),
            onChanged: (gymOwnerName) => cubit.gymOwnerName = gymOwnerName,
            validator: (value) => validateSimpleData(value, context),
          ),
          // const SizedBox(height: 15),
          // CustomTextFormField(
          //   hint: "gmail".tr(context),
          //   onChanged: (gmail) => cubit.gymGmail = gmail,
          //   validator: (value) => validateEmail(context, value),
          // ),
          const SizedBox(height: 20),

          CustomTextFormField(
            hint: "separateByComma".tr(context),
            onChanged: (gymPhones) => cubit.gymPhones = gymPhones,
            validator: (value) => validatePhone2(value, context),
          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            readOnly: true,
            onTap: () {
              context.pushScreen(AppRoutes.authMapScreen);
            },
            controller: cubit.addressController,
            prefixIcon: const Icon(Icons.location_on),
            hint: "address".tr(context),
            validator: (value) => validateAddress(value, context),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            hint: "description".tr(context),
            onChanged: (description) => cubit.description = description,
            validator: (value) => validateSimpleData(value, context),
            minLines: 1,
            maxLines: 5,
          ),
          const SizedBox(height: 20),

          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return ChooseManyImageWidget(
                images: cubit.gymImages,
                hintText: "gymPhotos".tr(context),
                onImagesSelected: (images) {
                  cubit.uploadIImages(images);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
