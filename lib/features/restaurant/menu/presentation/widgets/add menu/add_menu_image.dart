import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/choose_single_image_widget.dart';
import 'package:wasla/features/restaurant/menu/presentation/manager/cubit/resident_menu_cubit.dart';

class AddMenuImage extends StatelessWidget {
  const AddMenuImage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentMenuCubit>();
    return BlocBuilder<ResidentMenuCubit, ResidentMenuState>(
      buildWhen: (previous, current) => current is ResidentMenuUpdateMenuImage,
      builder: (context, state) {
        return ChooseSingleImageWidget(
          image: cubit.menuImage,
          onImageSelected: (image) {
            cubit.updateMenuImage(image: image);
          },
        );
      },
    );
  }
}
