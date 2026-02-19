import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/resident_service/features/gym/data/models/gym_data_model.dart';
import 'package:wasla/features/resident_service/features/gym/data/repo/gym_resident_repo.dart';

part 'gym_resident_state.dart';

class GymResidentCubit extends Cubit<GymResidentState> {
  GymResidentCubit(this.gymResidentRepo) : super(GymResidentInitial());

  final GymResidentRepo gymResidentRepo;

  List<GymDataModel> allGyms = [];
  List<GymPackageModel> gymPackages = [];
  int pageNumber = 1;
  int pageSize = 6;
  int totalGyms = -1;
  GymModel? gym;
  int serviceIdFlag = -1;
  String selecedGymId = '';

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

  Future<void> getGymDetails({required String gymId}) async {
    emit(GymResidentGetGymDetailsLoading());
    final result = await GlobalRepo.geGymProfile(gymId: gymId);
    result.fold(
      (error) => emit(GymResidentGetGymDetailsFailure(errMsg: error)),
      (success) {
        gym = success;
        emit(GymResidentGetGymDetailsSuccess());
      },
    );
  }

  Future<void> getGymPackages({required String gymId}) async {
    gymPackages.clear();
    emit(GymResidentGetGymPackagesLoading());
    final result = await GlobalRepo.getGymPackagesAndOffers(gymId: gymId);
    result.fold(
      (error) => emit(GymResidentGetGymPackagesFailure(errMsg: error)),
      (success) {
        gymPackages = success;
        emit(GymResidentGetGymPackagesSuccess());
      },
    );
  }

  Future<void> bookAtGym({
    required String gymId,
    required int bookingId,
  }) async {
    serviceIdFlag = bookingId;
    emit(GymResidentBookingLoading());
    final String? residentId = await getUserId();
    final result = await gymResidentRepo.bookAtGym(
      gymId: gymId,
      serviceId: bookingId,
      residentId: residentId!,
    );
    result.fold(
      (error) {
        serviceIdFlag = -1;
        emit(GymResidentBookingFailure(errMsg: error));
      },
      (success) {
        emit(GymResidentBookingSuccess(qrCodeUrl:ApiEndPoints.qrBaseUrl + success));
      },
    );
  }

  void reset() {
    pageNumber = 1;
    pageSize = 6;
    totalGyms = -1;
    allGyms.clear();
    gym = null;
    serviceIdFlag = -1;
  }
}
