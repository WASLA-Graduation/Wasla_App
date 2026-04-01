part of 'gym_packages_cubit.dart';

sealed class GymPackagesState {}

final class GymPackagesInitial extends GymPackagesState {}

final class GymPackageUpdate extends GymPackagesState {}

final class GymGetPackagesAndOffersLoading extends GymPackagesState {}

final class GymGetPackagesAndOffersSuccess extends GymPackagesState {
  final List<GymPackageModel> data;
  GymGetPackagesAndOffersSuccess(this.data);
}

final class GymGetPackagesAndOffersError extends GymPackagesState {
  final String errorMessage;

  GymGetPackagesAndOffersError(this.errorMessage);
}

final class GymAddOrUpdatePackagesAndOffersLoading extends GymPackagesState {}

final class GymAddOrUpdatePackagesAndOffersSuccess extends GymPackagesState {}

final class GymAddOrUpdatePackagesAndOffersError extends GymPackagesState {
  final String errorMessage;

  GymAddOrUpdatePackagesAndOffersError(this.errorMessage);
}

final class GymDeletePackagesAndOffersLoading extends GymPackagesState {}

final class GymDeletePackagesAndOffersSuccess extends GymPackagesState {}

final class GymDeletePackagesAndOffersError extends GymPackagesState {
  final String errorMessage;

  GymDeletePackagesAndOffersError(this.errorMessage);
}
