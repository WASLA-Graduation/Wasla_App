import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/models/user_model.dart';
import 'package:wasla/features/resident_service/features/home/data/repo/home_repo.dart';

part 'home_resident_state.dart';

class HomeResidentCubit extends Cubit<HomeResidentState> {
  final HomeRepo homeRepo;
  HomeResidentCubit(this.homeRepo) : super(HomeResidentInitial());

  int currentIndex = 0;
  int navBarcurrentIndex = 0;
  UserModel? user;

  void updateCurrentIndex(int index) {
    currentIndex = index;
    emit(HomeResidentUpadateCurrentIndex());
  }

  void updateNavBarCurrentIndex(int index) {
    navBarcurrentIndex = index;
    emit(HomeResidentUpadateCurrentIndex());
  }

  Future<void> getResidentProfile() async {
    emit(HomeResidentGetProfileLoading());
    final userId = await SecureStorageHelper.get(key: ApiKeys.userId);
    final response = await homeRepo.getResidentProfile(
      userId: "18f1ce3b-83eb-4d63-9e4e-e64debce6192",
    );
    response.fold(
      (error) {
        emit(HomeResidentGetProfileFailure(errMsg: error));
      },
      (success) {
        user = success;
        emit(HomeResidentGetProfileSuccess());
      },
    );
  }
}
