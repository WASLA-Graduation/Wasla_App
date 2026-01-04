import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_file_from_device.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/auth/presentation/widgets/certificate_uploade_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class DocEditProfileForm extends StatelessWidget {
  const DocEditProfileForm({super.key, required this.doc});
  final DoctorModel doc;

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
          key: cubit.residentFormKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 8,
              children: [
                CustomTextFormField(
                  withTitle: true,
                  title: "full_name".tr(context),
                  initealValue: doc.fullName,
                  onChanged: (name) {
                    cubit.fullName = name;
                  },
                  validator: (value) => validateName(value, context),
                ),
                CustomTextFormField(
                  initealValue: doc.phoneNumberBase,
                  keyboardTyp: TextInputType.phone,
                  withTitle: true,
                  title: "phone".tr(context),
                  onChanged: (phone) {
                    cubit.phoneNumber = phone;
                  },
                  validator: (value) => validatePhone(value, context),
                ),

                CustomTextFormField(
                  withTitle: true,
                  title: "hostpitalName".tr(context),
                  initealValue: doc.hospitalname,
                  onChanged: (hospital) {
                    cubit.hospitalName = hospital;
                  },
                  validator: (value) => validateName(value, context),
                ),
                CustomTextFormField(
                  withTitle: true,
                  title: "experience".tr(context),
                  keyboardTyp: TextInputType.number,
                  initealValue: doc.experienceYears.toString(),
                  onChanged: (years) {
                    cubit.experienceYears = years.isEmpty
                        ? doc.experienceYears
                        : int.parse(years);
                  },
                  validator: (value) => validateSimpleData(value, context),
                ),
                const SizedBox(),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return UploadFileButton(
                      title: "uplodCv".tr(context),
                      fileName: cubit.file?.name,
                      isUploaded: cubit.file != null,
                      onTap: () async {
                        final file = await getFileFromDevice();
                        if (file != null) {
                          cubit.updateFile(file);
                        }
                      },
                    );
                  },
                ),

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
              ],
            ),
          ),
        );
      },
    );
  }
}
