import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';

class CustomDoctorAddServiceForm extends StatelessWidget {
  const CustomDoctorAddServiceForm({super.key});

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
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "Service Name (EN)",
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            onChanged: (value) {
              cubit.serviceNameAr = value;
            },
            validator: (value) => validateSimpleData(value, context),

            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "Service Name (AR)",
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            onChanged: (value) {
              cubit.serviceDescEn = value;
            },
            validator: (value) => validateSimpleData(value, context),

            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "Description (EN)",
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            onChanged: (value) {
              cubit.serviceDescAr = value;
            },
            validator: (value) => validateSimpleData(value, context),

            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "Description (AR)",
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            keyboardTyp: TextInputType.number,
            onChanged: (value) {
              cubit.price = int.parse(value);
            },
            validator: (value) => validateSimpleData(value, context),

            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "Price",
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
