import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/booking_filter.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/repo/resident_booking_repo.dart';

part 'resident_booking_state.dart';

class ResidentBookingCubit extends Cubit<ResidentBookingState> {
  ResidentBookingCubit(this.bookingRepo) : super(ResidentBookingInitial());
  final ResidentBookingRepo bookingRepo;

  List<GeneralResidentBookingsModel> allBookings = [];

  BookingFilter bookingFilter = BookingFilter.doctorBookings;

  int selectedBookingFlag = -1;
  void updateBookingTaps({required BookingFilter bookingFilter}) {
    if (bookingFilter == this.bookingFilter) return;
    this.bookingFilter = bookingFilter;
    getAllBookingsByStatus();
  }

  Future<void> getAllBookingsByStatus() async {
    emit(ResidentGetBookingLoading());
    String? userId = await getUserId();

    final result = await _getRightBookings(userId);
    result.fold(
      (error) {
        emit(ResidentGetBookingFailure(errMsg: error));
      },
      (success) {
        allBookings = success;
        emit(ResidentAllGetBookingSuccess());
      },
    );
  }

  Future<void> cancelResidentBooking({
    required int bookingId,
    required int index,
  }) async {
    selectedBookingFlag = bookingId;
    emit(ResidentCancelBookingLoading());
    final result = await _getRightCancelBooking(bookingId: bookingId);
    result.fold(
      (error) {
        emit(ResidentCacelBookingFailure(errMsg: error));
        selectedBookingFlag = -1;
      },
      (success) {
        allBookings.removeAt(index);
        emit(ResidentCancelBookingSuccess());
      },
    );
  }

  _getRightCancelBooking({required int bookingId}) async {
    switch (bookingFilter) {
      case BookingFilter.doctorBookings:
        return await bookingRepo.doctorCancelBooking(
          bookingId: bookingId,
          status: 3,
        );
      case BookingFilter.gymBookings:
        return await bookingRepo.gymCancelBooking(bookingId: bookingId);
      case BookingFilter.returnBookings:
        // TODO: Handle this case.
        throw UnimplementedError();
      case BookingFilter.driverBookings:
        // TODO: Handle this case.
        throw UnimplementedError();
      case BookingFilter.technicianBookings:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  _getRightBookings(String? userId) async {
    switch (bookingFilter) {
      case BookingFilter.doctorBookings:
        return await bookingRepo.getResidentBookingsWithDoctor(userId: userId!);
      case BookingFilter.gymBookings:
        return await bookingRepo.getResidentBookingsWithGym(
          residentId: userId!,
        );

      case BookingFilter.returnBookings:
        // TODO: Handle this case.
        throw UnimplementedError();
      case BookingFilter.driverBookings:
        // TODO: Handle this case.
        throw UnimplementedError();
      case BookingFilter.technicianBookings:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void resetState() {
    bookingFilter = BookingFilter.doctorBookings;
    selectedBookingFlag = -1;
  }
}
