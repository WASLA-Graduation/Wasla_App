import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/menu/resident_menu_repo.dart';

class ResidentMenuRepoImpl extends ResidentMenuRepo {
  final ApiConsumer api;

  ResidentMenuRepoImpl({required this.api});
}
