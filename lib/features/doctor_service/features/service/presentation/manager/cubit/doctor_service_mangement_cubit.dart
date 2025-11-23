
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_service_mangement_state.dart';

class DoctorServiceMangementCubit extends Cubit<DoctorServiceMangementState> {
  DoctorServiceMangementCubit() : super(DoctorServiceMangementInitial());
}
