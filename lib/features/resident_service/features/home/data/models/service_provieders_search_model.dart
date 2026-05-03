
class ServiceProviedersSearchModel {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String description;
  final double rating;
  final String phone;
  final String role;

  ServiceProviedersSearchModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.description,
    required this.rating,
    required this.phone,
    required this.role,
  });

  factory ServiceProviedersSearchModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviedersSearchModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photo: json['photo'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
