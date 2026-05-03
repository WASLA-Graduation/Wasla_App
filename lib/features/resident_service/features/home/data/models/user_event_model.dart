class UserEventModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final String roleName;
  final double rating;

  UserEventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.roleName,
    required this.rating,
  });

  factory UserEventModel.fromJson(Map<String, dynamic> json) {
    return UserEventModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      roleName: json['roleName'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'roleName': roleName,
      'rating': rating,
    };
  }
}