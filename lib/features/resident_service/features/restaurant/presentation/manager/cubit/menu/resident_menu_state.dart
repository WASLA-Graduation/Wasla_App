part of 'resident_menu_cubit.dart';

sealed class ResidentMenuState {
  const ResidentMenuState();

}

final class ResidentMenuInitial extends ResidentMenuState {}

///Basics State
final class ResidentMenuNetworkState extends ResidentMenuState {}
final class ResidentMenuFailureState extends ResidentMenuState {}
final class ResidentMenuOnRetryState extends ResidentMenuState {}

