part of 'home_resident_cubit.dart';

sealed class HomeResidentState {}

final class HomeResidentInitial extends HomeResidentState {}


/// 3 basic states


final class HomeResidentNetworkState  extends HomeResidentState {}
final class HomeResidentFailureState  extends HomeResidentState {}
final class HomeResidentOnRetryState  extends HomeResidentState {}


/////close search bar
final class HomeResidentCloseSearchBar extends HomeResidentState {}



//// get service providers
final class HomeResidentGetServicesLoading  extends HomeResidentState {}
final class HomeResidentGetServicesLoaded  extends HomeResidentState {
  final List<ServiceProviedersSearchModel>serviceProviders;
  HomeResidentGetServicesLoaded({required this.serviceProviders});
}
final class HomeResidentGetServicesLoadingFromPagination  extends HomeResidentState {}








final class HomeResidentUpadateCurrentIndex extends HomeResidentState {}

final class HomeResidentGetProfileLoading extends HomeResidentState {}

final class HomeResidentGetProfileSuccess extends HomeResidentState {}

final class HomeResidentGetProfileFailure extends HomeResidentState {
  final String errMsg;
  HomeResidentGetProfileFailure({required this.errMsg});
}
