import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/custom_profile_picture.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_docotor_info_form.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_show_Bottom_sheet_image.dart';

class DoctorInfoBody extends StatelessWidget {
  const DoctorInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
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
                child: CustomDocotorInfoForm(),
              ),
            ],
          ),
        );
      },
    );
  }
}
