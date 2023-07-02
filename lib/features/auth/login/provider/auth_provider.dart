import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';
import '../repo/auth_repo.dart';
import '../../../../../navigation/custom_navigation.dart';
import '../../../../../navigation/routes.dart';
import '../../../../app/core/utils/app_snack_bar.dart';
import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/localization/localization/language_constant.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo,}){
    _mailTEC = TextEditingController(text:kDebugMode ? "adel@gmail.com" : authRepo.getMail());
    _passwordTEC=TextEditingController();
  }

  late final TextEditingController _mailTEC;
  TextEditingController get mailTEC => _mailTEC;

  late final TextEditingController _passwordTEC;
  TextEditingController get passwordTEC => _passwordTEC;

  String _token = "";
  String get token => _token;


  bool _isRememberMe = true;
  bool get isRememberMe => _isRememberMe;
  void onRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

  bool _isAgree = true;
  bool get isAgree => _isAgree;
  void onAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  logIn() async {
    try {
        _isLoading = true;
        notifyListeners();
        Either<ServerFailure, Response> response = await authRepo.logIn(phone: _mailTEC.text.trim(),);
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          notifyListeners();
        }, (success) {
          if(_isRememberMe){
            authRepo.remember(_mailTEC.text.trim());
          }else{
            authRepo.forget();
          }
          _token=success.data['data']["api_token"];
          CustomNavigator.push(
            Routes.VERIFICATION,);
        });
        _isLoading = false;
        notifyListeners();

    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLoading = false;
      notifyListeners();
    }
  }

  verifyPhone({required String code}) async {

CustomNavigator.push(Routes.EDIT_PROFILE,replace: true,arguments: true);
    //
    // try {
    //   _isSubmit = true;
    //   notifyListeners();
    //   Either<ServerFailure, Response> response = await authRepo.verifyPhone(
    //     phone: "+966${_phoneTEC.text.trim()}",
    //     code: code,
    //   );
    //   response.fold((fail) {
    //     CustomSnackBar.showSnackBar(
    //         notification: AppNotification(
    //             message: fail.error,
    //             isFloating: true,
    //             backgroundColor: ColorResources.IN_ACTIVE,
    //             borderColor: Colors.transparent));
    //     notifyListeners();
    //   }, (success) {
    //     authRepo.saveUserToken(token:_token);
    //     authRepo.setLoggedIn();
    //     if(isLoginBefore){
    //       CustomNavigator.push(Routes.DASHBOARD, replace: true);
    //     }else{
    //
    //     }
    //   });
    //   _isSubmit = false;
    //   notifyListeners();
    // } catch (e) {
    //   _isSubmit = false;
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: e.toString(),
    //           isFloating: true,
    //           backgroundColor: ColorResources.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   notifyListeners();
    // }
  }


  logOut() async {
    CustomNavigator.push(Routes.LOGIN, clean: true);
    await authRepo.clearSharedData();
    CustomSnackBar.showSnackBar(
        notification: AppNotification(
            message: getTranslated("your_logged_out_successfully", CustomNavigator.navigatorState.currentContext!),
            isFloating: true,
            backgroundColor: ColorResources.ACTIVE,
            borderColor: Colors.transparent));
    notifyListeners();
  }
}
