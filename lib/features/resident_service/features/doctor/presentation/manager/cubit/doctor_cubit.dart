import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/features/resident_service/features/doctor/data/repo/doctor_repo.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepo doctorRepo;
  DoctorCubit(this.doctorRepo) : super(DoctorInitial());
  List<DoctorSpecializationaModel> specialityList = [];

  int specializationIndex = 0;

  void changeSpecializationIndex(int index) {
    specializationIndex = index;
    emit(DoctorUpdateState());
  }

  Future<void> getDoctorSpecialization() async {
    emit(DoctorGetSpecialityListLoading());
    specialityList.clear();
    final response = await doctorRepo.getSpecialization();
    response.fold(
      (error) {
        emit(DoctorGetSpecialityListFailure(errMsg: error));
      },
      (success) {
        specialityList = success;
        specialityList.insert(
          0,
          DoctorSpecializationaModel(id: 100, specialization: "All"),
        );
        emit(DoctorGetSpecialityListSuccess());
      },
    );
  }
}
