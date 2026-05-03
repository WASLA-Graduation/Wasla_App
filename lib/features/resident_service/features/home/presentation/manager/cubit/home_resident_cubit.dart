import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/enums/event_type.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/resident_service/features/home/data/models/service_provieders_search_model.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_event_model.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';
import 'package:wasla/features/resident_service/features/home/data/repo/home_repo.dart';

part 'home_resident_state.dart';

class HomeResidentCubit extends Cubit<HomeResidentState> {
  final HomeRepo homeRepo;
  HomeResidentCubit(this.homeRepo) : super(HomeResidentInitial());

  int currentIndex = 0;
  int navBarcurrentIndex = 0;
  UserModel? user;

  final pageSize = 5;
  int allServiceProvidersPageNumber = 1;
  int searchServiceProvidersPageNumber = 1;
  bool isEndOfAllServiceProviders = false;
  bool isEndOfSearchServiceProviders = false;

  bool isSearch = false;

  String query = '';

  bool isCloseSearch = true;

  List<ServiceProviedersSearchModel> allServiceProviders = [];
  List<ServiceProviedersSearchModel> searchedServiceProviders = [];

  void onRetry() {
    emit(HomeResidentOnRetryState());
  }

  void whenUserSearch() {
    if (query.length == 1) {
      isCloseSearch = false;
      emit(HomeResidentCloseSearchBar());
    } else if (query.isEmpty) {
      isCloseSearch = true;
      emit(HomeResidentCloseSearchBar());
    }
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    emit(HomeResidentUpadateCurrentIndex());
  }

  void updateNavBarCurrentIndex(int index) {
    navBarcurrentIndex = index;
    emit(HomeResidentUpadateBottomNavBarCurrentIndex());
  }

  Future<void> getResidentProfile() async {
    final String? userId = await SecureStorageHelper.get(key: ApiKeys.userId);
    final response = await homeRepo.getResidentProfile(userId: userId!);
    response.fold((error) {}, (success) {
      user = success;
      emit(HomeResidentGetProfileSuccess());
    });
  }

  Future<void> getAllServiceProviders({required bool fromPagination}) async {
    if (isEndOfAllServiceProviders ||
        state is HomeResidentGetServicesLoadingFromPagination) {
      return;
    }
    if (fromPagination) {
      emit(HomeResidentGetServicesLoadingFromPagination());
    } else {
      emit(HomeResidentGetServicesLoading());
    }

    final result = await homeRepo.getAllServiceProviders(
      pageNumber: allServiceProvidersPageNumber,
      pageSize: pageSize,
    );

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(HomeResidentNetworkState());
        } else {
          emit(HomeResidentFailureState());
        }
      },
      (success) {
        if (success.isEmpty) {
          isEndOfAllServiceProviders = true;
        } else {
          allServiceProvidersPageNumber++;
          allServiceProviders.addAll(success);
        }
        emit(
          HomeResidentGetServicesLoaded(serviceProviders: allServiceProviders),
        );
      },
    );
  }

  Future<void> searchInAllServiceProviders({
    required bool fromPagination,
  }) async {
    isSearch = true;

    if (query.isEmpty) {
      isSearch = false;
      searchServiceProvidersPageNumber = 1;
      isEndOfSearchServiceProviders = false;
      searchedServiceProviders = [];

      emit(
        HomeResidentGetServicesLoaded(serviceProviders: allServiceProviders),
      );
      return;
    }

    if (!fromPagination) {
      searchServiceProvidersPageNumber = 1;
      isEndOfSearchServiceProviders = false;
      searchedServiceProviders = [];
    }

    if (isEndOfSearchServiceProviders ||
        state is HomeResidentGetServicesLoadingFromPagination) {
      return;
    }

    if (fromPagination) {
      emit(HomeResidentGetServicesLoadingFromPagination());
    }

    final result = await homeRepo.searchAllServiceProviders(
      pageNumber: searchServiceProvidersPageNumber,
      pageSize: pageSize,
      query: query,
    );

    result.fold(
      (failure) {
        emit(HomeResidentGetServicesLoaded(serviceProviders: []));
      },
      (success) {
        if (success.isEmpty) {
          isEndOfSearchServiceProviders = true;
        } else {
          searchServiceProvidersPageNumber++;
          searchedServiceProviders.addAll(success);
        }

        emit(
          HomeResidentGetServicesLoaded(
            serviceProviders: searchedServiceProviders,
          ),
        );
      },
    );
  }

  Future<void> getRecommendedServiceProviders() async {
    emit(HomeResidentGetRecommendedForYouLoading());

    final String? userId = await getUserId();
    final result = await homeRepo.getServiceProviderRecommendedForYou(
      residentId: userId!,
      top: 5,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(HomeResidentNetworkState());
        } else {
          emit(HomeResidentFailureState());
        }
      },
      (success) {
        emit(HomeResidentGetRecommendedForYouLoaded(recommendedList: success));
      },
    );
  }

  Future<void> getServiceProvidersTopOfTheWeek() async {
    emit(HomeResidentGetTopOfTheWeekLoading());

    final result = await homeRepo.getServiceProviderTopOfTheWeek(top: 5);
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(HomeResidentNetworkState());
        } else {
          emit(HomeResidentFailureState());
        }
      },
      (success) {
        emit(HomeResidentGetTopOfTheWeekLoaded(topWeekList: success));
      },
    );
  }

  Future<void> createUserEvent({
    required String serviceProviderId,
    required EventType eventType,
  }) async {
    final String? userId = await getUserId();

    final result = await homeRepo.createUserEvent(
      eventType: eventType,
      serviceProviderId: serviceProviderId,
      userId: userId!,
    );
    result.fold((_) {}, (_) {});
  }

  void reset() {
    allServiceProviders = [];
    allServiceProvidersPageNumber = 1;
    isEndOfAllServiceProviders = false;
    isEndOfSearchServiceProviders = false;
    searchServiceProvidersPageNumber = 1;
    isSearch = false;
    searchedServiceProviders = [];
    query = '';
    isCloseSearch = true;
  }
}
