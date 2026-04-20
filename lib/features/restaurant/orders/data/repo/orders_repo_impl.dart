import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/restaurant/orders/data/repo/orders_repo.dart';

class OrdersRepoImpl extends OrdersRepo {
  final ApiConsumer api;

  OrdersRepoImpl({required this.api});
}
