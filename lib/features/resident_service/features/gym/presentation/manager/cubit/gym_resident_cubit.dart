import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/gym/data/models/gym_data_model.dart';
import 'package:wasla/features/resident_service/features/gym/data/repo/gym_resident_repo.dart';

part 'gym_resident_state.dart';

class GymResidentCubit extends Cubit<GymResidentState> {
  GymResidentCubit(this.gymResidentRepo) : super(GymResidentInitial());

  final GymResidentRepo gymResidentRepo;

  List<GymDataModel> allGyms = [];
  int pageNumber = 1;
  int pageSize = 6;
  int totalGyms = -1;

  Future<void> getAllGyms({required bool fromPagination}) async {
    if (totalGyms == allGyms.length) {
      return;
    }
    if (fromPagination) {
      emit(GymResidentGetAllGymsFromPaginationLoading());
    } else {
      emit(GymResidentGetAllGymsLoading());
    }
    final result = await gymResidentRepo.getAllGym(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    result.fold((err) => emit(GymResidentGetAllGymsFailure(errMsg: err)), (
      success,
    ) {
      if (success.gyms.isNotEmpty) {
        pageNumber++;
        totalGyms = success.totalCount;
        allGyms.addAll(success.gyms);
      }
      emit(GymResidentGetAllGymsSuccess());
    });
  }

  void reset() {
    pageNumber = 1;
    pageSize = 6;
    totalGyms = -1;
    allGyms.clear();
  }
}
