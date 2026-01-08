import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/models/service_provider_fav_model.dart';
import 'package:wasla/core/repo/favourite_repo.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepo favouriteRepo;
  FavouriteCubit(this.favouriteRepo) : super(FavouriteInitial());

  List<ServiceProviderModel> allFavouriteList = [];
  List<ServiceProviderModel> favouritesByTypeList = [];
  List<int> favouriteListId = [];

  Future<void> getAllFavourites({required String residentId}) async {
    emit(GetFavouriteLoading());
    allFavouriteList.clear();
    favouriteListId.clear();
    final response = await favouriteRepo.getAllFavourites(
      residentId: residentId,
    );
    response.fold(
      (error) {
        emit(GetFavouriteFailure(message: error));
      },
      (success) {
        allFavouriteList = success;
        for (var element in allFavouriteList) {
          favouriteListId.add(element.id);
        }
        emit(GetFavouriteSuccess());
      },
    );
  }

  Future<void> getFavouritesByType({
    required String residentId,
    required int serviceType,
  }) async {
    emit(GetFavouriteLoading());
    favouritesByTypeList.clear();
    favouriteListId.clear();
    final response = await favouriteRepo.getFavouritesByType(
      residentId: residentId,
      serviceType: serviceType,
    );
    response.fold(
      (error) {
        emit(GetFavouriteFailure(message: error));
      },
      (success) {
        favouritesByTypeList = success;
        for (var element in favouritesByTypeList) {
          favouriteListId.add(element.id);
        }
        emit(GetFavouriteSuccess());
      },
    );
  }

  Future<void> addToFavourite({
    required String residentId,
    required String serviceId,
    required int favouriteId,
  }) async {
    favouriteListId.add(favouriteId);
    emit(AddToFavouriteLoading());
    final response = await favouriteRepo.addToFavorite(
      residentId: residentId,
      serviceId: serviceId,
    );
    response.fold(
      (error) {
        favouriteListId.remove(favouriteId);
        emit(AddToFavouriteFailure(message: error));
      },
      (success) {
        emit(AddToFavouriteSuccess());
      },
    );
  }

  Future<void> removeFromFavorite({required int favouriteId}) async {
    favouriteListId.remove(favouriteId);
    emit(RemoveFromFavouriteLoading());
    final response = await favouriteRepo.removeFromFavorite(
      favouriteId: favouriteId,
    );
    response.fold(
      (error) {
        favouriteListId.add(favouriteId);
        emit(RemoveFromFavouriteFailure(message: error));
      },
      (success) {
        emit(RemoveFromFavouriteSuccess());
      },
    );
  }

  bool checkFavourite(int id) {
    return favouriteListId.contains(id);
  }

  void reset() {
    allFavouriteList.clear();
    favouritesByTypeList.clear();
    favouriteListId.clear();
  }
}
