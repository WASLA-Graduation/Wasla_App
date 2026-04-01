import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> getImageFromMobile({required bool fromGallary}) async {
  ImagePicker imagePicke = ImagePicker();
  if (fromGallary) {
    XFile? xFile = await imagePicke.pickImage(source: ImageSource.gallery);
    return xFile == null ? null : File(xFile.path);
  } else {
    XFile? xFile = await imagePicke.pickImage(source: ImageSource.camera);
    return xFile == null ? null : File(xFile.path);
  }
}

Future<List<File>> pickMultipleImages() async {
  final ImagePicker imagePicker = ImagePicker();

  final List<XFile> xFiles = await imagePicker.pickMultiImage();

  if (xFiles.isEmpty) return [];

  return xFiles.map((x) => File(x.path)).toList();
}
