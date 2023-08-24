import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  getCategoryDetails(id) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getCategoryDetails(id);
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

  getSubCategoryDetails(id) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getSubCategoryDetails(id);
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

  CategoryItem? currentCategory;
  setCurrentCategory(CategoryItem catItem) {
    currentCategory = catItem;
    notifyListeners();
  }

  late int currentTab = 0;
  selectTab(v) {
    currentTab = v;
    print(selectTab);
    getSubCategoryDetails(currentCategory!.subCategory![v].id);
    // getProducts();
    notifyListeners();
  }
}
