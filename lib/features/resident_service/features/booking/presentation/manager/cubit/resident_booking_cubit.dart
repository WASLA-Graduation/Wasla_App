import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/repo/resident_booking_repo.dart';

part 'resident_booking_state.dart';

class ResidentBookingCubit extends Cubit<ResidentBookingState> {
  ResidentBookingCubit(this.bookingRepo) : super(ResidentBookingInitial());
  final ResidentBookingRepo bookingRepo;
  List<ResidentBookingModel> bookings = [];
  List<ResidentBookingModel> upComingbookings = [];
  List<ResidentBookingModel> cancelledbookings = [];
  List<ResidentBookingModel> completedbookings = [];

  int currentTap = 0;

  void updateCurrentTap({required int index}) {
    currentTap = index;
    emit(ResidentBookingUpdate());
  }

  Future<void> getResidentBookings() async {
    emit(ResidentGetBookingLoading());
    bookings.clear();
    upComingbookings.clear();
    cancelledbookings.clear();
    completedbookings.clear();

    String? userId = await getUserId();
    final response = await bookingRepo.getResidentBookings(userId: userId!);
    response.fold(
      (error) {
        emit(ResidentGetBookingFailure(errMsg: error));
      },
      (success) {
        bookings = success;
        filterBookings();
        emit(ResidentGetBookingSuccess(bookings: upComingbookings));
      },
    );
  }

  void filterBookings() {
    for (var booking in bookings) {
      if (booking.status == 1) {
        upComingbookings.add(booking);
      } else if (booking.status == 3) {
        cancelledbookings.add(booking);
      } else if (booking.status == 2) {
        completedbookings.add(booking);
      }
    }
  }

  void getBookingByCurrentTap() {
    if (currentTap == 0) {
      emit(ResidentGetBookingSuccess(bookings: upComingbookings));
    } else if (currentTap == 2) {
      emit(ResidentGetBookingSuccess(bookings: cancelledbookings));
    } else if (currentTap == 1) {
      emit(ResidentGetBookingSuccess(bookings: completedbookings));
    }
  }

  Future<void> cancelBooking({
    required int bookingId,
    required int index,
  }) async {
    emit(ResidentCancelBookingLoading());
    final response = await bookingRepo.removeBooking(
      bookingId: bookingId,
      status: 3,
    );
    response.fold(
      (error) {
        emit(ResidentCacelBookingFailure(errMsg: error));
      },
      (success) {
        cancelledbookings.add(upComingbookings[index]);
        upComingbookings.removeAt(index);
        emit(ResidentCancelBookingSuccess());
      },
    );
  }
}
