class OrderModel {
  final int id;
  final String residentId;
  final String residentName;
  final double totalPrice;
  final String address;
  final String notes;
  final double deliveryFee;
  final String? paymobOrderId;
  final String? paymentKey;
  final String? transactionId;
  final int status;
  final int paymentStatus;
  final int paymentMethod;
  final DateTime createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.residentId,
    required this.residentName,
    required this.totalPrice,
    required this.address,
    required this.notes,
    required this.deliveryFee,
    required this.paymobOrderId,
    required this.paymentKey,
    required this.transactionId,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      residentId: json['residentId'],
      residentName: json['residentName'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      address: json['address'],
      notes: json['notes'],
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      paymobOrderId: json['paymobOrderId'],
      paymentKey: json['paymentKey'],
      transactionId: json['transactionId'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}


class OrderItemModel {
  final int menuItemId;
  final int orderItemId;
  final String orderItemName;
  final double price;
  final int quantity;

  OrderItemModel({
    required this.menuItemId,
    required this.orderItemId,
    required this.orderItemName,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      menuItemId: json['menuItemId'],
      orderItemId: json['orderItemId'],
      orderItemName: json['orderItemName'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}