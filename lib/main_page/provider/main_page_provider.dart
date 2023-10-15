import 'package:flutter/material.dart';
import 'package:live/features/profile/repo/profile_repo.dart';

class MainPageProvider extends ChangeNotifier {
  final ProfileRepo repo;
  MainPageProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  bool? isOpen;
  updateIsOpen(v) {
    isOpen = v;
    notifyListeners();
  }

  int selectedIndex = 0;

  updateDashboardIndex(v, {bool isOpen = false}) {
    isOpen = false;
    selectedIndex = v;
    notifyListeners();
  }
}
