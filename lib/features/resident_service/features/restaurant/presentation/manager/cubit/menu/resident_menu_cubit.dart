import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/menu/resident_menu_repo.dart';

part 'resident_menu_state.dart';

class ResidentMenuCubit extends Cubit<ResidentMenuState> {
  ResidentMenuCubit(this.menu) : super(ResidentMenuInitial());

  final ResidentMenuRepo menu;

  void onRetry() {
    emit(ResidentMenuOnRetryState());
  }
}
