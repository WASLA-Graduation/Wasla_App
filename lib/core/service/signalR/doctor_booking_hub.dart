import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasla/core/service/signalR/models/booking_hub_model.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';

class BookingSignalRService {
  late HubConnection _connection;

  Future<void> connect(BuildContext context) async {
    _connection = HubConnectionBuilder()
        .withUrl("https://waslammka.runasp.net/bookingHub")
        .withAutomaticReconnect()
        .build();

    _connection.onclose(({error}) {});

    await _connection.start();
  }

  void listen(BuildContext context) {
    _connection.on("Bookingcanceled", (args) {
      final data = args?[0] as Map<String, dynamic>;
      BookingHubModel bookingHubModel = BookingHubModel.fromJson(data);
      context.read<DoctorCubit>().whenSlotOfServiceCancelBook(
        bookingHubModel: bookingHubModel,
      );
        context.read<DoctorHomeCubit>().whenServiceBookedOrCanceled(
        booking: bookingHubModel,
      );
    });

    _connection.on("BookingUpdated", (args) {
      print("Booking updated");
      print(args?[0]);
    });

    _connection.on("ServiceDayBooked", (args) {
      final data = args?[0] as Map<String, dynamic>;
      BookingHubModel bookingHubModel = BookingHubModel.fromJson(data);
      context.read<DoctorCubit>().whenSlotOfServiceBooked(
        bookingHubModel: bookingHubModel,
      );
      context.read<DoctorHomeCubit>().whenServiceBookedOrCanceled(
        booking: bookingHubModel,
      );
    });
  }

  Future<void> disconnect() async {
    await _connection.stop();
  }
}
