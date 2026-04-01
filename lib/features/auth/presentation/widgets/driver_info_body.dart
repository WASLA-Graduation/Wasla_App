import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/driver_choose_images_and_files.dart';
import 'package:wasla/features/auth/presentation/widgets/driver_image.dart';
import 'package:wasla/features/auth/presentation/widgets/driver_info_form.dart';
import 'package:wasla/features/auth/presentation/widgets/drop_down_color.dart';

class DriverInfoBody extends StatelessWidget {
  const DriverInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Column(
      spacing: 20,
      children: [
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              DriverImage(),
              const SizedBox(height: 20),
              DriverInfoForm(),
              DriverChooseFilesAndImages(),
              const SizedBox(height: 20),
              DropDownColors(
                onSelected: (color) {
                  context.read<AuthCubit>().updateVehicleColor(color: color);
                },
              ),
            ],
          ),
        ),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthDriverCompleteInfoFailure) {
              toastAlert(color: AppColors.error, msg: state.errMsg);
            }
            if (state is AuthDriverCompleteInfoSuccess) {
              context.pushReplacementScreen(AppRoutes.signInScreen);
            }
          },
          builder: (context, state) {
            return GeneralButton(
              onPressed: () {
                if (cubit.driverInfoformKey.currentState!.validate()) {
                  cubit.driverCompleteInfo();
                }
              },
              text: state is AuthDriverCompleteInfoLoading
                  ? 'loading'.tr(context)
                  : 'save'.tr(context),
            );
          },
        ),
      ],
    );
  }
}
