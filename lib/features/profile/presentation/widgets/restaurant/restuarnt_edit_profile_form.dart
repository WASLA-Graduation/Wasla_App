import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class RestaurantEditProfileForm extends StatelessWidget {
  const RestaurantEditProfileForm({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Form(
      key: cubit.restaurantFormKey,
      child: Column(
        spacing: AppSizes.paddingSizeSmall,
        children: [
          CustomTextFormField(
            initealValue: restaurantModel.name,
            withTitle: true,
            title: "restaurantName".tr(context),
            hint: "restaurantName".tr(context),
            onChanged: (name) => cubit.serviceName = name,
            validator: (value) => validateSimpleData(value, context),
          ),
          CustomTextFormField(
            initealValue: restaurantModel.ownerName,
            withTitle: true,
            title: "restaurantOwnerName".tr(context),
            hint: "restaurantOwnerName".tr(context),
            onChanged: (name) => cubit.ownerName = name,
            validator: (value) => validateSimpleData(value, context),
          ),
          CustomTextFormField(
            initealValue: restaurantModel.phoneNumber,

            withTitle: true,
            title: "phoneNumber".tr(context),
            keyboardTyp: TextInputType.phone,
            hint: "phoneNumber".tr(context),
            onChanged: (phone) => cubit.phoneNumber = phone,
            validator: (value) => validatePhone2(value, context),
          ),

          CustomTextFormField(
            initealValue: restaurantModel.description,
            withTitle: true,
            title: "description".tr(context),
            hint: "description".tr(context),
            onChanged: (description) => cubit.description = description,
            validator: (value) => validateSimpleData(value, context),
            minLines: 1,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
