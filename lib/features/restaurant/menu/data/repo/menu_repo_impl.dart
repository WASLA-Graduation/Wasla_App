import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/restaurant/menu/data/repo/menu_repo.dart';

class MenuRepoImpl extends MenuRepo {
  final ApiConsumer api;

  MenuRepoImpl({required this.api});
}
