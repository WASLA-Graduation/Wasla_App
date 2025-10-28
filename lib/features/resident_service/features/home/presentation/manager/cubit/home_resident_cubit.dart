import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_resident_state.dart';

class HomeResidentCubit extends Cubit<HomeResidentState> {
  HomeResidentCubit() : super(HomeResidentInitial());

  int currentIndex = 0;
  int navBarcurrentIndex = 0;

  void updateCurrentIndex(int index) {
    currentIndex = index;
    emit(HomeResidentUpadateCurrentIndex());
  }
  void updateNavBarCurrentIndex(int index) {
    navBarcurrentIndex = index;
    emit(HomeResidentUpadateCurrentIndex());
  }
}
