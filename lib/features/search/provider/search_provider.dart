import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../../home/models/places_model.dart';
import '../repo/search_repo.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepo searchRepo;

  SearchProvider({
    required this.searchRepo,
  });


  bool isLoading = false;
  PlacesModel? placesModel;
  TextEditingController searchTEC = TextEditingController();

  search() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await searchRepo.search(query:searchTEC.text.trim());
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        placesModel = PlacesModel.fromJson(response.data);

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

}
