import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/gym/features/packages/data/repo/gym_packages_repo.dart';

part 'gym_packages_state.dart';

class GymPackagesCubit extends Cubit<GymPackagesState> {
  GymPackagesCubit(this.gymPackagesRepo) : super(GymPackagesInitial());
  final GymPackagesRepo gymPackagesRepo;
  List<GymPackageModel> packages = [];
  List<GymPackageModel> offers = [];

  GlobalKey<FormState> gymAddUpdateFormKey = GlobalKey();

  String descriptionArabic = "",
      descriptionEnglish = "",
      nameArabic = "",
      nameEnglish = "";

  double price = 0.0,packagePercentage=0.0;
  int gymPackagTypeValue = 0;

  int durationPackage = 0;

  File? packageImage;
  int tapsCurrentIndex = 0;

  void updateCurrentTap({required int index}) {
    tapsCurrentIndex = index;
    emit(GymPackageUpdate());
  }



void updatePackageImage({required File image}) {
    packageImage = image;
    emit(GymPackageUpdate());
  }
  void updateGymPackageTypeValue({required int value}) {
    gymPackagTypeValue = value;
    emit(GymPackageUpdate());
  }

  void getPackagesOrOffersByCurrentTap() {
    if (tapsCurrentIndex == 0) {
      emit(GymGetPackagesAndOffersSuccess(packages));
    } else {
      emit(GymGetPackagesAndOffersSuccess(offers));
    }
  }

  Future<void> getGymPackagesAndOffers() async {
    packages.clear();
    offers.clear();
    final String? gymId = await getUserId();
    emit(GymGetPackagesAndOffersLoading());
    final result = await gymPackagesRepo.getGymPackagesAndOffers(gymId: gymId!);
    result.fold((error) => emit(GymGetPackagesAndOffersError(error)), (
      success,
    ) {
      for (var package in success) {
        if (package.type == 1) {
          packages.add(package);
        }
        if (package.type == 2) {
          offers.add(package);
        }
      }
      emit(
        GymGetPackagesAndOffersSuccess(
          tapsCurrentIndex == 0 ? packages : offers,
        ),
      );
    });
  }

  Future<void> addOrUpdatePackageOrOffer({required bool isAdding}) async {
    if (packageImage == null) {
      emit(
        GymAddOrUpdatePackagesAndOffersError(
          "Please select an image for the package or offer",
        ),
      );
      return;
    }

    emit(GymAddOrUpdatePackagesAndOffersLoading());
    final result = await gymPackagesRepo.addOrUpdatePackageOrOffer(
      model: GymPackageRequestModel(
        descriptionArabic: descriptionArabic,
        descriptionEnglish: descriptionEnglish,
        nameArabic: nameArabic,
        nameEnglish: nameEnglish,
        price: price,
        photo: packageImage!,
        durationInMonths: durationPackage,
        precentage: isAdding ? 0.0 :packagePercentage,
        type: isAdding ? 1 : 2,
        serviceProviderId: getUserId() as String,
      ),
      isAdding: isAdding,
    );
    result.fold((error) => emit(GymAddOrUpdatePackagesAndOffersError(error)), (
      success,
    ) {
      packageImage = null;
      emit(GymAddOrUpdatePackagesAndOffersSuccess());
    });
  }

  Future<void> deletePackageOrOffer({required int serviceId}) async {
    emit(GymDeletePackagesAndOffersLoading());

    final result = await gymPackagesRepo.deletePackageOrOffer(
      serviceId: serviceId,
    );
    result.fold(
      (error) {
        emit(GymDeletePackagesAndOffersError(error));
      },
      (success) {
        getGymPackagesAndOffers();
        emit(GymDeletePackagesAndOffersSuccess());
      },
    );
  }
}
