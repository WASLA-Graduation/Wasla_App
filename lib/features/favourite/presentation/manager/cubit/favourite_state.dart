part of 'favourite_cubit.dart';

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class AddToFavouriteLoading extends FavouriteState {}

final class AddToFavouriteSuccess extends FavouriteState {}

final class AddToFavouriteFailure extends FavouriteState {
  final String message;
  AddToFavouriteFailure({required this.message});
}

final class RemoveFromFavouriteLoading extends FavouriteState {}

final class RemoveFromFavouriteSuccess extends FavouriteState {}

final class RemoveFromFavouriteFailure extends FavouriteState {
  final String message;
  RemoveFromFavouriteFailure({required this.message});
}

final class GetFavouriteLoading extends FavouriteState {}

final class GetFavouriteSuccess extends FavouriteState {}

final class GetFavouriteFailure extends FavouriteState {
  final String message;
  GetFavouriteFailure({required this.message});
}
