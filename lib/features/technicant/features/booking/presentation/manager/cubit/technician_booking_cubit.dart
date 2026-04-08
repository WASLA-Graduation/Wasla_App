import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/technicant/features/booking/data/repo/technician_bookings_repo.dart';

part 'technician_booking_state.dart';

class TechnicianBookingCubit extends Cubit<TechnicianBookingState> {
  TechnicianBookingCubit(this.technicianBookingsRepo)
    : super(TechincainBookingInitialState());

  final TechnicianBookingsRepo technicianBookingsRepo;

  int currentTap = 0;

  void whenRetry() {
    emit(TechincainBookingOnRetryState());
  }

  void updateCurrentTap({required int index}) {
    if (currentTap != index) {
      currentTap = index;
      emit(TechincainBookingUpdateCurrentTapState());

      ///get booking according to current tap
    }
  }
}
