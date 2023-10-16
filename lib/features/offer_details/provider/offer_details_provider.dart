import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/offers_model.dart';
import '../repo/offer_details_repo.dart';

class OfferDetailsProvider extends ChangeNotifier {
  OfferDetailsRepo repo;
  OfferDetailsProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  OfferItem? model;
  bool isLoading = false;
  getDetails(id) async {
    // try {
      isLoading = true;
      model = null;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getOfferDetails(id);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (success.data["data"] != null) {
          model = OfferItem.fromJson(success.data["data"]);
        }
      });
      isLoading = false;
      notifyListeners();
    // } catch (e) {
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: e.toString(),
    //           isFloating: true,
    //           backgroundColor: ColorResources.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   isLoading = false;
    //   notifyListeners();
    // }
  }
}
