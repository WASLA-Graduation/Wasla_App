import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';

abstract class BaseOrderModel {
  final int id;
  final double totalPrice;
  final String address;
  final String notes;
  final double deliveryFee;
  final String? paymentKey;
  final String? transactionId;
  final PaymentStatus paymentStatus;
  final int paymentMethod;
  final DateTime createdAt;
  final List<OrderItemModel> items;
  OrderStatus status;

  BaseOrderModel({
    required this.status,
    required this.id,
    required this.totalPrice,
    required this.address,
    required this.notes,
    required this.deliveryFee,
    required this.paymentKey,
    required this.transactionId,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.createdAt,
    required this.items,
  });
}

class OrderItemModel {
  final int menuItemId;
  final int orderItemId;
  final String orderItemName;
  final double price;
  final int quantity;

  const OrderItemModel({
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

  Map<String, dynamic> toJson() {
    return {
      'menuItemId': menuItemId,
      'orderItemId': orderItemId,
      'orderItemName': orderItemName,
      'price': price,
      'quantity': quantity,
    };
  }
}
