class TechnicianModel {
  final String email;
  final String fullName;
  final String phone;
  final String birthDay;
  final int experienceYears;
  final String description;
  final double latitude;
  final double longitude;
  final int specialty;
  final String profilePhotoUrl;
  final List<String> documentsUrls;
  final int rate;
  final bool isAvailable;

  TechnicianModel({
    required this.email,
    required this.fullName,
    required this.phone,
    required this.birthDay,
    required this.experienceYears,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.specialty,
    required this.profilePhotoUrl,
    required this.documentsUrls,
    required this.rate,
    required this.isAvailable,
  });

  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      birthDay: json['birthDay'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      description: json['description'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      specialty: json['specialty'] ?? 0,
      profilePhotoUrl: json['profilePhotoUrl'] ?? '',
      documentsUrls: List<String>.from(json['documentsUrls'] ?? []),
      rate: json['rate'] ?? 0,
      isAvailable: json['isAvailable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'birthDay': birthDay,
      'experienceYears': experienceYears,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'specialty': specialty,
      'profilePhotoUrl': profilePhotoUrl,
      'documentsUrls': documentsUrls,
      'rate': rate,
      'isAvailable': isAvailable,
    };
  }
}