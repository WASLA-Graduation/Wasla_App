import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_service_mangement_state.dart';

class DoctorServiceMangementCubit extends Cubit<DoctorServiceMangementState> {
  DoctorServiceMangementCubit() : super(DoctorServiceMangementInitial());
  Set<int> daysIndices = {};
  bool? daysSelected;
  final GlobalKey<FormState> addServiceFormKey = GlobalKey<FormState>();
  String serviceNameAr = '',
      serviceNameEn = '',
      serviceDescAr = '',
      serviceDescEn = '';
  int price = 0;

  void addOrRemoveDaysIndex(int index) {
    if (daysIndices.contains(index)) {
      daysIndices.remove(index);
    } else {
      daysIndices.add(index);
    }
    emit(DoctorServiceMangementUpdate());
  }


  void checkDaysSelected() {
    if (daysIndices.isEmpty) {
      daysSelected = false;
    } else {
      daysSelected = true;
    }
    emit(DoctorServiceMangementUpdate());
  }
}
