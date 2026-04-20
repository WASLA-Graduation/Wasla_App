part of 'menu_cubit.dart';

sealed class MenuState  {
  const MenuState();

}

final class MenuInitial extends MenuState {}

////Basics Stats
final class GetMenuFailureState extends MenuState {}
final class GetMenuNetWorkState extends MenuState {}
final class OnRetryState extends MenuState {}
