import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/Update_restaurant_reservation_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/details/resident_restaurant_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/table%20reservatoin/resident_res_reservation_body.dart';

class UpdateReservationView extends StatefulWidget {
  final UpdateRestaurantReservationModel reservationModel;
  const UpdateReservationView({super.key, required this.reservationModel});

  @override
  State<UpdateReservationView> createState() => _UpdateReservationViewState();
}

class _UpdateReservationViewState extends State<UpdateReservationView> {
  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(title: Text("updateReservation".tr(context))),

      body: ResidentRestaurantReservationViewBody(
        restaurantId: '',
        reservationModel: widget.reservationModel,
      ),
    );
  }

  setData() {
    final cubit = context.read<ResidentRestaurantCubit>();
    cubit.numberOfPersons = widget.reservationModel.numberOfPersons;
    cubit.selectedDate = widget.reservationModel.reservationDate;
    cubit.selectedTimeSlot = widget.reservationModel.reservationTime;
  }
}
