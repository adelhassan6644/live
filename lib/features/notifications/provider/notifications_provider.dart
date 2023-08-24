
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';
import '../../../navigation/custom_navigation.dart';
import '../model/notifications_model.dart';
import '../repo/notifications_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  NotificationsRepo notificationsRepo;
  NotificationsProvider({required this.notificationsRepo});

  bool goingDown = false;
  scroll(controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        goingDown = false;
        notifyListeners();
      } else {
        goingDown = true;
        notifyListeners();
      }
    });
  }

  bool get isLogin => notificationsRepo.isLoggedIn();

  NotificationsModel? model;
  bool isLoading = false;
  getNotifications() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await notificationsRepo.getNotifications();
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
        model = NotificationsModel.fromJson(success.data);
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

  readNotification(id) async {
    try {
      await notificationsRepo.readNotification(id);
      notifyListeners();
    } catch (e) {
      showToast(getTranslated("something_went_wrong",
          CustomNavigator.navigatorState.currentContext!));
      notifyListeners();
    }
  }

  deleteNotification(id) async {
    try {
      loadingDialog();
      notifyListeners();
      Either<ServerFailure, Response> response =
          await notificationsRepo.deleteNotification(id);
      response.fold((l) async {
        CustomNavigator.pop();
        showToast(ApiErrorHandler.getMessage(l));
      }, (response) async {
        model!.data!.removeWhere((e) => e.id == id);
        CustomNavigator.pop();
        showToast(getTranslated("notification_deleted_successfully",
            CustomNavigator.navigatorState.currentContext!));
      });
      notifyListeners();
    } catch (e) {
      CustomNavigator.pop();
      showToast(
        getTranslated("something_went_wrong",
            CustomNavigator.navigatorState.currentContext!),
      );
      notifyListeners();
    }
  }
}
