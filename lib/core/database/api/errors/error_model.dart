import 'package:wasla/core/database/api/api_keys.dart';

class ErrorModel {
  // final int statusCode;
  final String errorMessage;
  ErrorModel({required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(errorMessage: json[ApiKeys.msg]);
  }
}
