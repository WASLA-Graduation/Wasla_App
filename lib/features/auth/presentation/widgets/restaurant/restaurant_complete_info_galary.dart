import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/choose_many_images.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class RestaurantCompleteInfoGalary extends StatelessWidget {
  const RestaurantCompleteInfoGalary({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => current is AuthSuccessChooseFile,
      builder: (context, state) {
        return ChooseManyImageWidget(
          images: cubit.restaurantImages,
          hintText: "restaurantGalary".tr(context),
          onImagesSelected: (images) {
            cubit.updateRestaurantGalary(images);
          },
        );
      },
    );
  }
}
