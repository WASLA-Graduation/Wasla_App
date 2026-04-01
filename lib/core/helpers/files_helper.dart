import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;

abstract class FileHelper {
  static String getFileName(File file) => path.basename(file.path);
  static String getFileWithoutExtension(File file) =>
      path.basenameWithoutExtension(file.path);
  static String getFileExtension(File file) => path.extension(file.path);

  static Future<File?> downloadFile({
    required String url,
    ValueChanged<double>? onProgress,
  }) async {
    try {
      final file = await FileDownloader.downloadFile(
        url: url,
        onProgress: (fileName, progress) {
          if (onProgress != null) {
            onProgress(progress);
          }
        },
      );

      return file;
    } catch (e) {
      return null;
    }
  }

  static Future<void> openFile(File file) async =>
      await OpenFilex.open(file.path);

  static Future<PlatformFile?> getFileFromDevice() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'PDF', 'DOCX'],
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      return result.files.single;
    } else {
      return null;
    }
  }

  static Future<List<PlatformFile>> getMultipleFilesFromDevice() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf', 'docx'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files;
    } else {
      return [];
    }
  }

  static Future<File?> getImageFromMobile({required bool fromGallary}) async {
    ImagePicker imagePicke = ImagePicker();
    if (fromGallary) {
      XFile? xFile = await imagePicke.pickImage(source: ImageSource.gallery);
      return xFile == null ? null : File(xFile.path);
    } else {
      XFile? xFile = await imagePicke.pickImage(source: ImageSource.camera);
      return xFile == null ? null : File(xFile.path);
    }
  }

  static Future<List<File>> pickMultipleImages() async {
    final ImagePicker imagePicker = ImagePicker();

    final List<XFile> xFiles = await imagePicker.pickMultiImage();

    if (xFiles.isEmpty) return [];

    return xFiles.map((x) => File(x.path)).toList();
  }

  static Future<File?> getVideoFromMobile({required bool fromGallary}) async {
    ImagePicker imagePicke = ImagePicker();
    if (fromGallary) {
      XFile? xFile = await imagePicke.pickVideo(source: ImageSource.gallery);
      return xFile == null ? null : File(xFile.path);
    } else {
      XFile? xFile = await imagePicke.pickVideo(source: ImageSource.camera);
      return xFile == null ? null : File(xFile.path);
    }
  }

  static Future<List<MultipartFile>> convertPlatformFilesToMultipart(
    List<PlatformFile> files,
  ) async {
    return Future.wait(
      files
          .map(
            (file) => MultipartFile.fromFile(file.path!, filename: file.name),
          )
          .toList(),
    );
  }

  static Future<List<MultipartFile>> convertImagesToMultipart(
    List<File> files,
  ) async {
    return Future.wait(
      files.map(
        (file) async => await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      ),
    );
  }

  static Future<MultipartFile?> convertImageToMultipart(File? image) async {
    if (image == null) return null;

    return await MultipartFile.fromFile(
      image.path,
      filename: image.path.split('/').last,
    );
  }

  static Future<MultipartFile?> convertFileToMultipart(
    PlatformFile? file,
  ) async {
    if (file == null) return null;

    return await MultipartFile.fromFile(file.path!, filename: file.name);
  }
}
