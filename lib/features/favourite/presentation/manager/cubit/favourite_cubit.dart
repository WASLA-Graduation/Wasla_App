import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/favourite/data/models/service_provider_fav_model.dart';
import 'package:wasla/features/favourite/data/repo/favourite_repo.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepo favouriteRepo;
  FavouriteCubit(this.favouriteRepo) : super(FavouriteInitial());

  List<ServiceProviderModel> allFavouriteList = [];
  List<ServiceProviderModel> favouritesByTypeList = [];
  List<String> favouriteListId = [];

  Future<void> getAllFavourites() async {
    emit(GetFavouriteLoading());
    final String? residentId = await getUserId();
    allFavouriteList.clear();
    favouriteListId.clear();
    final response = await favouriteRepo.getAllFavourites(
      residentId: residentId!,
    );
    response.fold(
      (error) {
        emit(GetFavouriteFailure(message: error));
      },
      (success) {
        allFavouriteList = success;
        for (var element in allFavouriteList) {
          favouriteListId.add(element.serviceProviderId);
        }
        emit(GetFavouriteSuccess());
      },
    );
  }

  Future<void> getFavouritesByType({required int serviceType}) async {
    final String? residentId = await getUserId();
    emit(GetFavouriteLoading());
    favouritesByTypeList.clear();
    favouriteListId.clear();
    final response = await favouriteRepo.getFavouritesByType(
      residentId: residentId!,
      serviceType: serviceType,
    );
    response.fold(
      (error) {
        emit(GetFavouriteFailure(message: error));
      },
      (success) {
        favouritesByTypeList = success;
        for (var element in favouritesByTypeList) {
          favouriteListId.add(element.serviceProviderId);
        }
        emit(GetFavouriteSuccess());
      },
    );
  }

  Future<void> addToFavourite({required String serviceId}) async {
    favouriteListId.add(serviceId);

    emit(AddToFavouriteLoading());
    final String? residentId = await getUserId();
    final response = await favouriteRepo.addToFavorite(
      residentId: residentId!,
      serviceId: serviceId,
    );
    response.fold(
      (error) {
        favouriteListId.remove(serviceId);
        emit(AddToFavouriteFailure(message: error));
      },
      (success) {
        getFavouritesByType(serviceType: 1);
        emit(AddToFavouriteSuccess());
      },
    );
  }

  Future<void> removeFromFavorite({
    required int favouriteId,
    required String serviceProviderId,
  }) async {
    favouriteListId.remove(serviceProviderId);

    print("*********************favId***************");
    print("*********************${favouriteId}***************");
    print("*********************favId***************");
    emit(RemoveFromFavouriteLoading());
    final response = await favouriteRepo.removeFromFavorite(
      favouriteId: favouriteId,
    );
    response.fold(
      (error) {
        favouriteListId.add(serviceProviderId);
        print("*********************ddddddddddddddddddddd***************");
        print("************************************");
        print("************************************");
        emit(RemoveFromFavouriteFailure(message: error));
      },
      (success) {
        favouritesByTypeList.removeWhere(
          (element) => element.serviceProviderId == serviceProviderId,
        );
        emit(RemoveFromFavouriteSuccess());
      },
    );
  }

  bool checkFavourite(String serviceProviderId) {
    return favouriteListId.contains(serviceProviderId);
  }

  int getFavIdForSpecificService(String serviceProviderId) {
    for (var element in favouritesByTypeList) {
      if (element.serviceProviderId == serviceProviderId) {
        return element.id;
      }
    }
    return 0;
  }

  void reset() {
    allFavouriteList.clear();
    favouritesByTypeList.clear();
    favouriteListId.clear();
  }
}
