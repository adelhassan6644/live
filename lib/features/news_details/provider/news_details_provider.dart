import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/offers_model.dart';
import '../../home/models/news_model.dart';
import '../repo/news_details_repo.dart';

class NEwsDetailsProvider extends ChangeNotifier {
  NewsDetailsRepo repo;
  NEwsDetailsProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  List<String> tabs = ["terms_conditions", "address", "contact_information"];
  int selectedTab = 0;
  onSelectTab(v) {
    selectedTab = v;
    notifyListeners();
  }

  bool goingDown = false;
  scroll(controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        goingDown = false;
      } else {
        goingDown = true;
      }
      notifyListeners();
    });
  }

  NewsItem?  model;
  bool isLoading = false;
  getDetails(id) async {
    // try {
    isLoading = true;
    model = null;
    notifyListeners();
    Either<ServerFailure, Response> response = await repo.getNewsDetails(id);
    response.fold((fail) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (success) {
      if (success.data["data"] != null) {
        model = NewsItem.fromJson(success.data["data"]);
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

  shareOffer(OfferItem offer) async {
    String link = "https://livealhmdanh.page.link/${offer.id}";
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(link),
      uriPrefix: "https://livealhmdanh.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.softwareCloud.live",
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.softwareCloud.live",
        appStoreId: "6451453145",
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
}
