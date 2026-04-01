import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/custom_profile_picture.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_resident_info_form.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_show_Bottom_sheet_image.dart';

class ResidentViewBody extends StatelessWidget {
  const ResidentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResidentCompleteInfoFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is AuthResidentCompleteInfoSuccess) {
          context.pushReplacementScreen(AppRoutes.signInScreen);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: const SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Center(
                  child: CustomProfilePicture(
                    image: cubit.residentImage,
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            ShowResidentBottomSheetImage(cubit: cubit),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const VerticalSpace(height: 4)),
              SliverFillRemaining(
                hasScrollBody: false,
                child: const CustomResidentInfoForm(),
              ),
            ],
          ),
        );
      },
    );
  }
}
