import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';

class CustomChatTextField extends StatelessWidget {
  const CustomChatTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<ChatCubit>().whenUserTyping();
      },
      controller: controller,
      cursorColor: Colors.black,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: "message".tr(context),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: IconButton(
          onPressed: () async {
            final cubit = context.read<ChatCubit>();
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
