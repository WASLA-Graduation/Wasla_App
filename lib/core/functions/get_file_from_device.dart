import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> getFileFromDevice() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'docx'],
    withData: true,
  );

  if (result != null && result.files.isNotEmpty) {
    return result.files.single;
  } else {
    return null;
  }
}
