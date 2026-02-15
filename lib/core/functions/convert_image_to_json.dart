import 'dart:io';
import 'package:dio/dio.dart';

Future<MultipartFile?> convertFileToMultipart(File? file) async {
  if (file == null) return null;

  return await MultipartFile.fromFile(
    file.path,
    filename: file.path.split('/').last,
  );
}

Future<MultipartFile?> convertImageToMultipart(File? image) async {
  if (image == null) return null;

  return await MultipartFile.fromFile(
    image.path,
    filename: image.path.split('/').last,
  );
}
