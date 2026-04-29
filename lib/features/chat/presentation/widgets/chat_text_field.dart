import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';

class CustomChatTextField extends StatelessWidget {
  const CustomChatTextField({
    super.key,
    required this.controller,
    required this.focusNode,
  });
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return TextField(
      focusNode: focusNode,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: (value) {
        context.read<ChatCubit>().whenUserTyping();
      },
      controller: controller,
      cursorColor: context.isDarkMode ? Colors.white : Colors.black,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.isDarkMode
            ? Colors.grey.shade800
            : Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: "message".tr(context),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: cubit.isEdit
            ? IconButton(
                onPressed: () {
                  cubit.whenUserCloseUpating();
                },
                icon: Icon(Icons.close, color: Colors.grey.shade400, size: 21),
              )
            : IconButton(
                onPressed: () async {
                  List<File> pickedImages = await pickMultipleImages();
                  if (pickedImages.isNotEmpty) {
                    cubit.pickImages(files: pickedImages);
                  }
                },
                icon: Icon(
                  Icons.image_outlined,
                  color: Colors.grey.shade400,
                  size: 21,
                ),
              ),
      ),
    );
  }
}
