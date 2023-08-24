import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:live/data/api/end_points.dart';
import 'package:live/features/place_details/repo/place_details_repo.dart';
import 'package:share/share.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../home/models/offers_model.dart';
import '../../home/models/places_model.dart';
import '../models/feed_backs.dart';

class PlaceDetailsProvider extends ChangeNotifier {
  PlaceDetailsRepo repo;
  PlaceDetailsProvider({required this.repo});

  late int placesIndex = 0;
  void setPlacesIndex(int index) {
    placesIndex = index;
    notifyListeners();
  }
  final TextEditingController commentTEC = TextEditingController();

  PlaceItem? model;
  bool isLoading = false;
  sharePlace(PlaceItem place) async {
    //

    String link = "https://softwarecloud.link/${place.id}";
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(link),
      uriPrefix: "https://softwarecloud.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.softwareCloud.live",
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.softwareCloud.live",
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(
      dynamicLinkParams,
    );

    String shareLink = Uri.decodeFull(
      Uri.decodeComponent(dynamicLink.toString()),
    );
    await Share.share(shareLink);
  }

  geDetails(id) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getPlaceDetails(id);
      response.fold((fail) {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        if (success.data["data"] != null) {
          model = PlaceItem.fromJson(success.data["data"]);
          getOffers();
          getFeedBacks();
        } else {
          model = null;
        }
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  followPlace(id) async {
    try {
      Either<ServerFailure, Response> response = await repo.followPlace(id);
      response.fold((fail) {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {

        if(!isFollow) {
          isFollow=true;
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "ستصلك جميع إشعارات ${model!.name}",
                  messageColor: ColorResources.SECOUND_PRIMARY_COLOR,
                  isFloating: true,
                  backgroundColor: ColorResources.ACCENT_PRIMARY_COLOR,
                  borderColor: Colors.transparent));
        }
        else{
          isFollow=false;
        }

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
  bool isFollow=false;
  checkFollowPlace(id) async {
    try {
      Either<ServerFailure, Response> response = await repo.checkFollowPlace(id);
      response.fold((fail) {

      }, (success) {
        isFollow=success.data['data'];
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
 double rateCount=0;
  setRate(rateCount){
  this.  rateCount=rateCount;
  notifyListeners();
  }
  bool isRatePlaceLoading = false;
  ratePlace() async {
    try {
      Either<ServerFailure, Response> response = await repo.ratePlace(model!.id,comment: commentTEC.text.trim(),rate: rateCount);
      response.fold((fail) {
        isRatePlaceLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "تم تقيم ${model!.name}",
                messageColor: ColorResources.SECOUND_PRIMARY_COLOR,
                isFloating: true,
                backgroundColor: ColorResources.ACCENT_PRIMARY_COLOR,
                borderColor: Colors.transparent));
        getFeedBacks();
        isRatePlaceLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isRatePlaceLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }


  late int _offersIndex = 0;
  int get offersIndex => _offersIndex;
  void setOffersIndex(int index) {
    _offersIndex = index;
    notifyListeners();
  }
  OffersModel? offersModel;
  bool isGetOffers = false;
  getOffers() async {
    try {
      isGetOffers = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getPlaceOffers(model?.id);
      response.fold((fail) {
        isGetOffers = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        offersModel = OffersModel.fromJson(success.data);
        isGetOffers = false;
        notifyListeners();
      });
    } catch (e) {
      isGetOffers = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  FeedBacks? feedBacks;
  bool isGetFeedBacks= false;
  getFeedBacks() async {
    try {
      isGetFeedBacks = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getPlaceFeedBacks(model!.id);
      response.fold((fail) {
        isGetFeedBacks = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        feedBacks = FeedBacks.fromJson(success.data);
        isGetFeedBacks = false;
        notifyListeners();
      });
    } catch (e) {
      isGetFeedBacks = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}
