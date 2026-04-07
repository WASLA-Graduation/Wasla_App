import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/technicant/features/booking/data/repo/technician_bookings_repo.dart';

part 'technician_booking_state.dart';

class TechnicianBookingCubit extends Cubit<TechnicianBookingState> {
  TechnicianBookingCubit(this.technicianBookingsRepo)
    : super(TechnicianBookingInitial());

  final TechnicianBookingsRepo technicianBookingsRepo;
}
