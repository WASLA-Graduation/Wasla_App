import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> getFileFromDevice() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'docx','PDF', 'DOCX'],
    withData: true,
  );

  if (result != null && result.files.isNotEmpty) {
    return result.files.single;
  } else {
    return null;
  }
}



Future<List<PlatformFile>> getMultipleFilesFromDevice() async {
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