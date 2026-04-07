import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/technicant/features/booking/data/repo/technician_bookings_repo.dart';

class TechnicianBookingsRepoImpl extends TechnicianBookingsRepo {
  final ApiConsumer api;

  TechnicianBookingsRepoImpl({required this.api});
}
