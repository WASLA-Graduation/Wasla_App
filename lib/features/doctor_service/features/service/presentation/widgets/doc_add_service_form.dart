import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';

class CustomDoctorAddServiceForm extends StatelessWidget {
  const CustomDoctorAddServiceForm({super.key, this.model});
  final DoctorServiceModel? model;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return Form(
      key: cubit.addServiceFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            onChanged: (value) {
              cubit.serviceNameEn = value;
            },
            initealValue: model?.serviceNameEnglish,
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "serviceNameEn".tr(context),
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            initealValue: model?.serviceNameArabic,
            onChanged: (value) {
              cubit.serviceNameAr = value;
            },
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "serviceNameAr".tr(context),
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            initealValue: model?.descriptionEnglish,
            onChanged: (value) {
              cubit.serviceDescEn = value;
            },
            validator: (value) => validateSimpleData(value, context),
            maxLines: 2,
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "descriptionEn".tr(context),
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            initealValue: model?.descriptionArabic,
            onChanged: (value) {
              cubit.serviceDescAr = value;
            },
            validator: (value) => validateSimpleData(value, context),
            maxLines: 2,
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "descriptionAr".tr(context),
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            initealValue: model?.price.toString(),
            keyboardTyp: TextInputType.number,
            onChanged: (value) {
              cubit.price = value.isEmpty ? 0 : double.parse(value);
            },
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "price".tr(context),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
