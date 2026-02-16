import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/gym_edit_profile_form.dart';

class GymEditProfileBody extends StatelessWidget {
  const GymEditProfileBody({super.key, required this.gym});
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Expanded(child: GymEditProfileForm(gym: gym)),
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
                if (cubit.gymFormKey.currentState!.validate()) {
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
    );
  }
}
