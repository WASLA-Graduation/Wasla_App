import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/choose_many_images.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class GymEditProfileForm extends StatelessWidget {
  const GymEditProfileForm({super.key, required this.gym});
  final GymModel gym;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateInfoFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is ProfileUpdateInfoSuccess) {
          toastAlert(
            color: AppColors.green,
            msg: "profile_updated_success".tr(context),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: cubit.gymFormKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 8,
              children: [
                CustomTextFormField(
                  withTitle: true,
                  title: "gymOwnerName".tr(context),
                  initealValue: gym.ownerName,
                  onChanged: (name) {
                    cubit.ownerName = name;
                  },
                  validator: (value) => validateName(value, context),
                ),
                CustomTextFormField(
                  withTitle: true,
                  title: "gymName".tr(context),
                  initealValue: gym.businessName,
                  onChanged: (name) {
                    cubit.businessName = name;
                  },
                  validator: (value) => validateName(value, context),
                ),
                CustomTextFormField(
                  initealValue: gym.description,
                  withTitle: true,
                  title: "description".tr(context),
                  onChanged: (description) {
                    cubit.description = description;
                  },
                  validator: (value) => validateSimpleData(value, context),
                ),
                CustomTextFormField(
                  hint: "separateByComma".tr(context),
                  initealValue: gym.phones.join(','),
                  onChanged: (gymPhones) => cubit.gymPhones = gymPhones,
                  validator: (value) => validatePhone2(value, context),
                ),

                // const SizedBox(),
                // GestureDetector(
                //   onTap: () {
                //     // openCvLink(doc.cv);
                //   },
                //   child: Text(
                //     "showCV".tr(context),
                //     style: TextStyle(
                //       color: Colors.blue,
                //       decoration: TextDecoration.underline,
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "address".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 10),

                InkWell(
                  onTap: () {
                    context.pushScreen(AppRoutes.authMapScreen);
                  },
                  child: Image.asset(
                    Assets.assetsImagesLocation,
                    fit: BoxFit.cover,
                  ),
                ),

                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return ChooseManyImageWidget(
                      images: cubit.images,
                      hintText: "gymPhotos".tr(context),
                      onImagesSelected: (images) {
                        cubit.uploadIImages(images);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
