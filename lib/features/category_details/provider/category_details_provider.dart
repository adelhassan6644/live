import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live/data/error/api_error_handler.dart';
import 'package:live/features/category_details/repo/category_details_repo.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../../home/models/categories_model.dart';
import '../model/category_details_model.dart';

class CategoryDetailsProvider extends ChangeNotifier {
  CategoryDetailsRepo repo;
  CategoryDetailsProvider({required this.repo});

  CategoryDetailsModel? model;
  bool isLoading = false;

  getCategoryDetails(id,{String? minRate, Position? position,bool? offer,bool? latestOffer}) async {
    // try {
    isLoading = true;
    notifyListeners();
    Either<ServerFailure, Response> response =
        await repo.getCategoryDetails(id,minRate: minRate, position: position,latestOffer: latestOffer,offer: offer);
    response.fold((fail) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(fail),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }, (success) {
      model = CategoryDetailsModel.fromJson(success.data);
      isLoading = false;
      notifyListeners();
    });
    // } catch (e) {
    //   isLoading = false;
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: e.toString(),
    //           isFloating: true,
    //           backgroundColor: ColorResources.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   notifyListeners();
    // }
  }

  getSubCategoryDetails(id, {String? minRate, Position? position,bool? offer,bool? latestOffer}) async {
    // try {
    isLoading = true;
    notifyListeners();
    Either<ServerFailure, Response> response = await repo
        .getSubCategoryDetails(id, minRate: minRate, position: position,latestOffer: latestOffer,offer: offer);
    response.fold((fail) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(fail),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }, (success) {
      model = CategoryDetailsModel.fromJson(success.data);
      isLoading = false;
      notifyListeners();
    });
    // } catch (e) {
    //   isLoading = false;
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: e.toString(),
    //           isFloating: true,
    //           backgroundColor: ColorResources.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   notifyListeners();
    // }
  }

  CategoryItem? currentCategory;
  setCurrentCategory(CategoryItem catItem) {
    currentCategory = catItem;
    notifyListeners();
  }

  int? rate;
  setCurrentRate(int rate) {
    this.rate = rate;
    notifyListeners();
  }

  Position? position;

  bool? nearset;
  setCurrentUserPosition(nearset) async {
    this.nearset = nearset;
    if (nearset)
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    notifyListeners();
  }
  bool? offer;
  setOffer(offer) async {
    this.offer = offer;

    notifyListeners();
  }
  bool? latestOffer;
  setLatestOffer(offer) async {
    latestOffer = offer;

    notifyListeners();
  }

  restFilter() {
    rate = null;
    position = null;
    nearset=null;
    offer=null;
    latestOffer=null;
    notifyListeners();
  }
  submitFilter() {
    print(currentTab);
    //
    if(currentTab==0) {
      getCategoryDetails(currentCategory!.id,minRate: "$rate",position: position,latestOffer: latestOffer,offer: offer);
    } else {
      getSubCategoryDetails(currentCategory!.subCategory![currentTab].id,minRate: "$rate",position: position,latestOffer: latestOffer,offer: offer);
    }


    restFilter();

  }

  late int currentTab = 0;
  selectTab(v) {
    currentTab = v;
    notifyListeners();
    if(v!=0)
    getSubCategoryDetails(currentCategory!.subCategory![v-1].id);

    notifyListeners();
  }
}
