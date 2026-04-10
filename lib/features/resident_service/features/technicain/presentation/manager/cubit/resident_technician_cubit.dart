import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/resident_technician_model.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/technician_specialization_model.dart';
import 'package:wasla/features/resident_service/features/technicain/data/repo/resident_technician_repo.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

part 'resident_technician_state.dart';

class ResidentTechnicianCubit extends Cubit<ResidentTechnicianState> {
  ResidentTechnicianCubit(this.repo) : super(ResidentTechnicianInitial());
  final ResidentTechnicianRepo repo;
  int pageSize = 10;
  int pageNumber = 1;
  bool endOfTechnicianPagination = false;
  int currentSpeciality = 1;

  void whenRetry() {
    emit(ResidentTechnicianOnRetry());
  }

  void chooseSpecialization({required int index}) {
    if (index != currentSpeciality) {
      currentSpeciality = index;
      emit(ResidentTechnicianSelectSpecialization());
      pageNumber = 1;
      endOfTechnicianPagination = false;
      getTechniciansBySpeciality(fromPagination: false);
    }
  }

  Future<void> getTechnicianSpecializations() async {
    emit(ResidentTechnicianGetSpecializationsLoading());
    final result = await repo.getTechnicianSpecialization();

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(ResidentTechnicianNetwork());
        } else {
          emit(ResidentTechnicianFailure());
        }
      },
      (success) {
        emit(
          ResidentTechnicianGetSpecializationsLoaded(specialiations: success),
        );
      },
    );
  }

  Future<void> getTechniciansBySpeciality({
    required bool fromPagination,
  }) async {
    if (endOfTechnicianPagination ||
        state is ResidentGetTechniciansSpecializationsLoadingFromPagination) {
      return;
    }
    if (fromPagination) {
      emit(ResidentGetTechniciansSpecializationsLoadingFromPagination());
    } else {
      emit(ResidentGetTechniciansSpecializationsLoading());
    }

    final result = await repo.getTechniciansBySpeciality(
      pageNumber: pageNumber,
      pageSize: pageSize,
      speciality: currentSpeciality,
    );

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(ResidentTechnicianNetwork());
        } else {
          emit(ResidentTechnicianFailure());
        }
      },
      (success) {
        if (success.isEmpty) {
          endOfTechnicianPagination = true;
        } else {
          pageNumber++;
        }

        emit(ResidentGetTechniciansSpecializationsLoaded(technicals: success));
      },
    );
  }

  Future<void> getTechnicianDetails({required String technicianId}) async {
    emit(ResidentGetTechnicianDetailsLoading());
    final result = await GlobalRepo.getTechnicianProfile(
      technicianId: technicianId,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(ResidentTechnicianNetwork());
        } else {
          emit(ResidentTechnicianFailure());
        }
      },
      (profile) =>
          emit(ResidentGetTechnicianDetailsLoaded(technician: profile)),
    );
  }
}
