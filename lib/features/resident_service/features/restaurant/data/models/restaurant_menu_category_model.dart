class RestaurantMenuCategoryModel {
  final int id;
  final NameModel name;
  final String nameValue;
  final String restaurantId;

  RestaurantMenuCategoryModel({
    required this.id,
    required this.name,
    required this.nameValue,
    required this.restaurantId,
  });

  factory RestaurantMenuCategoryModel.fromJson(Map<String, dynamic> json) {
    return RestaurantMenuCategoryModel(
      id: json['id'] ?? 0,
      name: NameModel.fromJson(json['name'] ?? {}),
      nameValue: json['nameValue'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
    );
  }
}

class NameModel {
  final String english;
  final String arabic;

  NameModel({required this.english, required this.arabic});

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      english: json['english'] ?? '',
      arabic: json['arabic'] ?? '',
    );
  }
}
