class TechnicianSpecializationModel {
  final int id;
  final String name;

  TechnicianSpecializationModel({required this.id, required this.name});

  factory TechnicianSpecializationModel.fromJson(Map<String, dynamic> json) {
    return TechnicianSpecializationModel(id: json['id'], name: json['name']);
  }
}
