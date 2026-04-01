import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';

class ChatChooseImagesWithText extends StatelessWidget {
  const ChatChooseImagesWithText({super.key, required this.files});

  final List<File> files;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: files.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              width: double.infinity,
                              height: SizeConfig.screenHeight / 2,
                              padding: const EdgeInsets.all(10),
                              child: Image.file(
                                files[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        child: Image.file(
                          files[index],
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            cubit.removeImage(file: files[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            onChanged: (value) {
              cubit.whenUserTyping();
            },
            controller: cubit.messageController,
            maxLines: 10,
            minLines: 1,
            decoration: InputDecoration(
              hintText: "message".tr(context),
              border: InputBorder.none,
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
          ),
        ],
      ),
    );
  }
}
