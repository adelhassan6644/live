import 'package:flutter/material.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../maps/models/location_model.dart';
import '../repo/home_repo.dart';
import 'package:flutter/rendering.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

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

  bool get isDriver => homeRepo.isDriver();
  bool get isLogin => homeRepo.isLoggedIn();

  int roleIndex = 0;
  List<String> roles = ["client", "driver"];
  List<String> titles = ["passenger", "captain"];
  onSelectRole(int value) {
    roleIndex = value;
    homeRepo.saveUserRole(roles[roleIndex]);
    notifyListeners();
  }

  List<String> genders = ["male", "female"];
  List<String> genderIcons = [SvgImages.maleIcon, SvgImages.femaleIcon];
  int gender = 0;
  selectedGender(int value) {
    gender = value;
    notifyListeners();
  }

  LocationModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;
    notifyListeners();
  }

  LocationModel? endLocation;
  onSelectEndLocation(v) {
    endLocation = v;
    notifyListeners();
  }

  reset() {
    startLocation = endLocation = null;
    gender = 0;
    notifyListeners();
  }

}
