class RestauarantMenuItemModel {
  final int categoryId;
  final String categoryName;
  final List<ItemModel> items;

  RestauarantMenuItemModel({
    required this.categoryId,
    required this.categoryName,
    required this.items,
  });

  factory RestauarantMenuItemModel.fromJson(Map<String, dynamic> json) {
    return RestauarantMenuItemModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      items: List<ItemModel>.from(
        json['items'].map((e) => ItemModel.fromJson(e)),
      ),
    );
  }
}

class ItemModel {
  final int id;
  final String name;
  final double price;
  final double discountPrice;
  final String imageUrl;
  final int preparationTime;
  final bool isAvailable;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.imageUrl,
    required this.preparationTime,
    required this.isAvailable,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      price: (json['price']).toDouble(),
      discountPrice: (json['discountPrice']).toDouble(),
      imageUrl: json['imageUrl'],
      preparationTime: json['preparationTime'],
      isAvailable: json['isAvailable'],
    );
  }
}
