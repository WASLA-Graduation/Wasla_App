
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/utils/size_config.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/core/widgets/custom_profile_picture.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_resident_info_form.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_show_Bottom_sheet_image.dart';

class ResidentInfoView extends StatelessWidget {
  const ResidentInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fill Your Profile")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 5,
            ),
            children: [
              const VerticalSpace(height: 5),
              Center(
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
              const VerticalSpace(height: 4),
              const CustomResidentInfoForm(),
            ],
          );
        },
      ),
    );
  }
}
