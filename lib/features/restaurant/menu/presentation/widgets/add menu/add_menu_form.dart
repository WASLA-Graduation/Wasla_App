import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/restaurant/menu/presentation/manager/cubit/resident_menu_cubit.dart';

class AddMenuForm extends StatelessWidget {
  const AddMenuForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentMenuCubit>();
    return Form(
      key: cubit.addMenuFormKey,
      child: Column(
        spacing: AppSizes.paddingSizeSmall,
        children: [
          CustomTextFormField(
            onChanged: (value) {},
            // initealValue: model?.serviceNameEnglish,
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "menuNameAr".tr(context),
          ),
          CustomTextFormField(
            onChanged: (value) {},
            // initealValue: model?.serviceNameEnglish,
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "menuNameEn".tr(context),
          ),
          CustomTextFormField(
            // initealValue: model?.price.toString(),
            keyboardTyp: TextInputType.number,
            onChanged: (value) {},
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "price".tr(context),
          ),
          CustomTextFormField(
            // initealValue: model?.price.toString(),
            keyboardTyp: TextInputType.number,
            onChanged: (value) {},
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "discount".tr(context),
          ),
          CustomTextFormField(
            // initealValue: model?.price.toString(),
            keyboardTyp: TextInputType.number,
            onChanged: (value) {},
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "preparationTime".tr(context),
          ),
        ],
      ),
    );
  }
}
