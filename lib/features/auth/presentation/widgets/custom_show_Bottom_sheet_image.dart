import 'dart:io';

import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/widgets/custom_choose_image_widget.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class ShowResidentBottomSheetImage extends StatelessWidget {
  const ShowResidentBottomSheetImage({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomChooseImageWidget(
      cameraOnPressed: () async {
        File? image = await getImageFromMobile(fromGallary: false);
        if (image != null) {
          cubit.updateResidentImage(image);
        }
        context.popScreen();
      },
      galaryOnPressed: () async {
        File? image = await getImageFromMobile(fromGallary: true);
        if (image != null) {
          cubit.updateResidentImage(image);
        }
        context.popScreen();
      },
    );
  }
}
