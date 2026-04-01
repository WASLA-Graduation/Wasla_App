import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/widgets/choose_single_image_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_choose_type_drop_down.dart';

class GymAddUpdatePackageForm extends StatefulWidget {
  const GymAddUpdatePackageForm({super.key, this.model});
  final GymPackageModel? model;

  @override
  State<GymAddUpdatePackageForm> createState() =>
      _GymAddUpdatePackageFormState();
}

class _GymAddUpdatePackageFormState extends State<GymAddUpdatePackageForm> {
  @override
  void initState() {
    fillData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return ListView(
      children: [
        DishaForm(model: widget.model),

        const SizedBox(height: 15),
        BlocBuilder<GymPackagesCubit, GymPackagesState>(
          builder: (context, state) {
            return ChooseSingleImageWidget(
              image: cubit.packageImage,
              onImageSelected: (file) {
                cubit.updatePackageImage(image: file);
              },
              hintText: "packageImage".tr(context),
            );
          },
        ),

        const SizedBox(height: 50),
      ],
    );
  }

  isEdit() {
    return widget.model != null;
  }

  void fillData() {
    if (isEdit()) {
      final model = widget.model!;
      final cubit = context.read<GymPackagesCubit>();
      cubit.nameEnglish = model.nameEn;
      cubit.nameArabic = model.nameAr;
      cubit.descriptionEnglish = model.descriptionEn;
      cubit.descriptionArabic = model.descriptionAr;
      cubit.price = model.price;
      cubit.durationPackage = model.durationInMonths;
      cubit.packagePercentage = model.precentage;
      cubit.gymPackagTypeValue = model.type == 1 ? 0 : 1;
    }
  }
}

class DishaForm extends StatelessWidget {
  const DishaForm({super.key, this.model});
  final GymPackageModel? model;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return Form(
      key: cubit.gymAddUpdateFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            initealValue: model?.nameEn,
            onChanged: (value) {
              cubit.nameEnglish = value;
            },
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "packageNameEnglish".tr(context),
          ),
          // const SizedBox(height: 15),
          CustomTextFormField(
            initealValue: model?.nameAr,
            onChanged: (value) {
              cubit.nameArabic = value;
            },
            validator: (value) => validateSimpleData(value, context),
            withBorder: true,
            fillColor: Colors.transparent,
            withTitle: true,
            title: "packageNameArabic".tr(context),
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            initealValue: model?.descriptionEn,
            onChanged: (value) {
              cubit.descriptionEnglish = value;
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
            initealValue: model?.descriptionAr,
            onChanged: (value) {
              cubit.descriptionArabic = value;
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
          isEdit()
              ? SizedBox()
              : CustomTextFormField(
                  initealValue: model?.durationInMonths.toString(),
                  keyboardTyp: TextInputType.number,
                  onChanged: (value) {
                    cubit.durationPackage = value.isEmpty
                        ? 0
                        : int.parse(value);
                  },
                  validator: (value) => validateSimpleData(value, context),
                  withBorder: true,
                  fillColor: Colors.transparent,
                  withTitle: true,
                  title: "packageDuration".tr(context),
                ),
          const SizedBox(height: 15),
          GymChooseTypeDropDown(initialValue: cubit.gymPackagTypeValue),
        ],
      ),
    );
  }

  isEdit() {
    return model != null;
  }
}
