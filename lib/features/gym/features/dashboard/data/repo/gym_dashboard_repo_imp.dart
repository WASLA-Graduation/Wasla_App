import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/gym/features/dashboard/data/repo/gym_dashboard_repo.dart';

class GymDashboardRepoImp extends GymDashboardRepo {
  final ApiConsumer api;

  GymDashboardRepoImp({required this.api});

}
