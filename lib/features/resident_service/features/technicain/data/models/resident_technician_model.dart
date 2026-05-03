class ResidentTechnicianModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String phoneNumber;
  final double rating;
  final String specialization;
  final int yearsOfExperience;

  ResidentTechnicianModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.phoneNumber,
    required this.rating,
    required this.specialization,
    required this.yearsOfExperience,
  });

  factory ResidentTechnicianModel.fromJson(Map<String, dynamic> json) {
    return ResidentTechnicianModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      specialization: json['specialization'] ?? '',
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
    );
  }


}