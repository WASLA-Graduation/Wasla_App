import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/driver/features/booking/data/repo/driver_booking_repo.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';

part 'driver_booking_state.dart';

class DriverBookingCubit extends Cubit<DriverBookingState> {
  DriverBookingCubit(this.driverBookingRepo) : super(DriverBookingInitial());
  final DriverBookingRepo driverBookingRepo;

  void onRetry() {
    emit(DriverBookingOnRetryState());
  }

  Future<void> getDriverBookings() async {
    final String? driverId = await getUserId();
    emit(DriverGetBookingsLoading());
    final result = await driverBookingRepo.getDriverBookings(
      driverId: driverId!,
    );
    result.fold((error) {
      if (error is NoInternetFailure) {
        emit(DriverBookingNetworkState());
      } else {
        emit(DriverBookingFailureState());
      }
    }, (success) => emit(DriverGetBookingsSuccess(allBookings: success)));
  }
}
