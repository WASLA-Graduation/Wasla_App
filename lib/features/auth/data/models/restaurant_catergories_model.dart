class RestaurantCatergoriesModel {
  final int id;
  final String name;

  RestaurantCatergoriesModel({required this.id, required this.name});

  factory RestaurantCatergoriesModel.fromJson(Map<String, dynamic> json) {
    return RestaurantCatergoriesModel(id: json['id'], name: json['name']);
  }
}
