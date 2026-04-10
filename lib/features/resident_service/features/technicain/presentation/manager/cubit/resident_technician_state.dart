part of 'resident_technician_cubit.dart';

sealed class ResidentTechnicianState extends Equatable {
  const ResidentTechnicianState();

  @override
  List<Object> get props => [];
}

final class ResidentTechnicianInitial extends ResidentTechnicianState {}

/// Basic States
final class ResidentTechnicianNetwork extends ResidentTechnicianState {}

final class ResidentTechnicianFailure extends ResidentTechnicianState {}

final class ResidentTechnicianOnRetry extends ResidentTechnicianState {}

final class ResidentTechnicianSelectSpecialization
    extends ResidentTechnicianState {}

/// Get Specialization States
final class ResidentTechnicianGetSpecializationsLoading
    extends ResidentTechnicianState {}

final class ResidentTechnicianGetSpecializationsLoaded
    extends ResidentTechnicianState {
  final List<TechnicianSpecializationModel> specialiations;

  const ResidentTechnicianGetSpecializationsLoaded({
    required this.specialiations,
  });
}

/// Get Technicals By Speciality States
final class ResidentGetTechniciansSpecializationsLoading
    extends ResidentTechnicianState {}

final class ResidentGetTechniciansSpecializationsLoadingFromPagination
    extends ResidentTechnicianState {}

final class ResidentGetTechniciansSpecializationsLoaded
    extends ResidentTechnicianState {
  final List<ResidentTechnicianModel> technicals;

  const ResidentGetTechniciansSpecializationsLoaded({required this.technicals});
}

///Get Technical Details
final class ResidentGetTechnicianDetailsLoading
    extends ResidentTechnicianState {
  const ResidentGetTechnicianDetailsLoading();
}

final class ResidentGetTechnicianDetailsLoaded extends ResidentTechnicianState {
  final TechnicianModel technician;

  const ResidentGetTechnicianDetailsLoaded({required this.technician});
}
