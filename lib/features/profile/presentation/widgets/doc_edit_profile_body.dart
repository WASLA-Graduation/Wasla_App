import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/doc_edit_form.dart';

class DocEditProfileBody extends StatelessWidget {
  const DocEditProfileBody({super.key, required this.doc});
  final DoctorModel doc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        spacing: 15,
        children: [
          Expanded(child: DocEditProfileForm(doc: doc)),
          GeneralButton(
            onPressed: () {
              context.pushScreen(AppRoutes.accountChangePassScreen);
            },
            text: "change_password".tr(context),
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final cubit = context.read<ProfileCubit>();
              return GeneralButton(
                onPressed: () {
                  if (cubit.residentFormKey.currentState!.validate()) {
                    cubit.updateUsertInfo();
                  }
                },
                text: state is ProfileUpdateInfoLoading
                    ? "loading".tr(context)
                    : "update".tr(context),
              );
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
