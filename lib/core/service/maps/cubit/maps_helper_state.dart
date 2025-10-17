part of 'maps_helper_cubit.dart';

sealed class MapsHelperState {}

final class MapsHelperInitial extends MapsHelperState {}

final class MapsHelperUpdateMapZoom extends MapsHelperState {}
final class MapsHelperBackToOriginalLocation extends MapsHelperState {}
final class MapsHelperUpdateMapLocation extends MapsHelperState {}

final class MapsHelperGetLocationLoading extends MapsHelperState {}

final class MapsHelperGetLocationSuccess extends MapsHelperState {}

final class MapsHelperGetLocationError extends MapsHelperState {
  final String message;
  MapsHelperGetLocationError({required this.message});
}
