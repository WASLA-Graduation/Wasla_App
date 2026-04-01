import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

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

Future<List<MultipartFile>> convertFilesToMultipart(List<File> files) async {
  return Future.wait(
    files.map(
      (file) async => await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    ),
  );
}

Future<List<MultipartFile>> convertPlatformFilesToMultipart(
  List<PlatformFile> files,
) async {
  return Future.wait(
    files
        .map((file) => MultipartFile.fromFile(file.path!, filename: file.name))
        .toList(),
  );
}
