part of 'technicant_dashboard_cubit.dart';

sealed class TechnicantDashboardState {}

final class TechnicantDashboardInitial extends TechnicantDashboardState {}

final class ChangeBottomNavBarIndexState extends TechnicantDashboardState {}

final class TechnicianGetProfile extends TechnicantDashboardState {
  final TechnicianModel technician;

  TechnicianGetProfile({required this.technician});
}

final class TechnicianNetworkState extends TechnicantDashboardState {}
