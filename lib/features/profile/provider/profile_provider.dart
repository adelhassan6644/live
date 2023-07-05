import 'dart:io';
import 'package:flutter/material.dart';
import '../repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({
    required this.profileRepo,
  });
  bool get isLogin => profileRepo.isLoggedIn();

  String? image;
  TextEditingController firstName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  File? profileImage;
  onSelectImage(File? file) {
    profileImage = file;
    notifyListeners();
  }
}
