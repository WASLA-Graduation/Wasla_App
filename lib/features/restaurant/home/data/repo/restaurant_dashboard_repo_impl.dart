import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/restaurant/home/data/repo/restaurant_dashboard_repo.dart';

class RestaurantDashboardRepoImpl extends RestaurantDashboardRepo {
  final ApiConsumer api;

  RestaurantDashboardRepoImpl({required this.api});
}
