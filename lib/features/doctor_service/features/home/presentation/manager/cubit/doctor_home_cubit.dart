import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_home_state.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  DoctorHomeCubit() : super(DoctorHomeInitial());

  int navBarCurrentIndex = 0;
  updateNavBarCurrentIndex(int index) {
    navBarCurrentIndex = index;
    emit(DoctorUpdate());
  }
}
