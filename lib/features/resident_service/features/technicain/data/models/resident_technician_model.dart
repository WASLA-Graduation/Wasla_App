class ResidentTechnicianModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String phoneNumber;
  final int rating;
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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'],
      rating: json['rating'],
      specialization: json['specialization'],
      yearsOfExperience: json['yearsOfExperience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'specialization': specialization,
      'yearsOfExperience': yearsOfExperience,
    };
  }
}
