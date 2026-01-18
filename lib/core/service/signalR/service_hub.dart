import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasla/core/service/signalR/models/service_hub_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';

class ServiceSignalRService {
  late HubConnection _connection;
  String? currentRoute;

  Future<void> connect() async {
    _connection = HubConnectionBuilder()
        .withUrl("https://waslammka.runasp.net/serviceHub")
        .withAutomaticReconnect()
        .build();

    _connection.onclose(({error}) {});

    await _connection.start();
  }

  void listen(BuildContext context) {
    _connection.on("ServiceAdded", (args) {
      final data = args?[0] as Map<String, dynamic>;
      ServiceHubData serviceHubModel = ServiceHubData.fromJson(data);
      context.read<DoctorCubit>().whenAddService(
        serviceHubModel: serviceHubModel,
      );
    });

    _connection.on("ServiceUpdated", (args) {
      final data = args?[0] as Map<String, dynamic>;
      ServiceHubData serviceHubModel = ServiceHubData.fromJson(data);

      context.read<DoctorCubit>().whenDeleteUpdateService(
        isUpdate: true,
        currentRoute: currentRoute!,
        serviceHubModel: serviceHubModel,
      );
    });

    _connection.on("ServiceDeleted", (args) {
      final data = args?[0] as Map<String, dynamic>;
      ServiceHubData serviceHubModel = ServiceHubData.fromJson(data);

      context.read<DoctorCubit>().whenDeleteUpdateService(
        isUpdate: false,
        currentRoute: currentRoute!,
        serviceHubModel: serviceHubModel,
      );
    });
  }

  Future<void> disconnect() async {
    await _connection.stop();
  }
}
