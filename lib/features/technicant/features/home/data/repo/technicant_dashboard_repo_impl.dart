import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/technicant/features/home/data/repo/technicant_dashboard_repo.dart';

class TechnicantDashboardRepoImpl extends TechnicantDashboardRepo {
  final ApiConsumer api;

  TechnicantDashboardRepoImpl({required this.api});
}
