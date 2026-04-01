import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/driver/features/booking/data/repo/driver_booking_repo.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

part 'driver_booking_state.dart';

class DriverBookingCubit extends Cubit<DriverBookingState> {
  DriverBookingCubit(this.driverBookingRepo) : super(DriverBookingInitial());
  final DriverBookingRepo driverBookingRepo;

  Future<void> getDriverBookings() async {
    final String? driverId = await getUserId();
    emit(DriverGetBookingsLoading());
    final result = await driverBookingRepo.getDriverBookings(
      driverId: driverId!,
    );
    result.fold(
      (error) => emit(DriverGetBookingsFailure(errorMessage: error)),
      (success) => emit(DriverGetBookingsSuccess(allBookings: success)),
    );
  }
}
