import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/restaurant/menu/data/repo/menu_repo.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.menu) : super(MenuInitial());
  final MenuRepo menu;

  void onRetry() {
    emit(OnRetryState());
  }
}
