import 'package:wasla/core/database/api/api_keys.dart';

class DoctorSpecializationaModel {
  final String specialization;
  final int id;

  DoctorSpecializationaModel({required this.id, required this.specialization});

  factory DoctorSpecializationaModel.fromJson(Map<String, dynamic> json) {
    return DoctorSpecializationaModel(
      id: json[ApiKeys.id],
      specialization: json[ApiKeys.name],
    );
  }
}
