import 'package:flutter_animate/flutter_animate.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/auth_provider.dart';

class Login extends StatefulWidget {
  final bool fromMain;
  const Login({Key? key, required this.fromMain}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isIndividual = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w,
            vertical: 40.h,
          ),
        child: Column(
          children: [
            Text(
              getTranslated(
                  "login_header", context),
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold
                  .copyWith(
                  fontSize: 28,
                  color:
                  ColorResources.HEADER),
            ),
            Padding(
              padding:
              EdgeInsets.only(bottom: 24.h),
              child: Text(
                getTranslated(
                    "login_description", context),
                textAlign: TextAlign.center,
                style: AppTextStyles.medium
                    .copyWith(
                    fontSize: 14,
                    color: ColorResources
                        .HINT_COLOR),
              ),
            ),
            // Toggle Buttons
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isIndividual = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: !isIndividual
                              ? ColorResources.PRIMARY_COLOR
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          getTranslated("business", context),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.medium.copyWith(
                            color: !isIndividual
                                ? Colors.white
                                : Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isIndividual = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isIndividual
                              ? ColorResources.PRIMARY_COLOR
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          getTranslated("individuals", context),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.medium.copyWith(
                            color: isIndividual
                                ? Colors.white
                                : Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(
                          sigmaX: 0.0, sigmaY: 0.0),
                      child: Consumer<AuthProvider>(
                          builder: (_, provider, child) {
                            return Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          controller:
                                          provider.mailTEC,
                                          hint: getTranslated(
                                              "phone_number", context),
                                          inputType: TextInputType
                                              .phone,
                                          valid: Validations.mail,
                                          pSvgIcon:
                                          SvgImages.phoneCallIcon,
                                        ),
/*
                                        CustomTextFormField(
                                          keyboardAction:
                                          TextInputAction.done,
                                          controller:
                                          provider.passwordTEC,
                                          hint: getTranslated(
                                              "password", context),
                                          inputType: TextInputType
                                              .visiblePassword,
                                          valid: Validations.password,
                                          pSvgIcon:
                                          SvgImages.lockIcon,
                                          isPassword: true,
                                        ),
*/
                             /*           SizedBox(
                                          height: 3.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                CustomNavigator.push(
                                                    Routes
                                                        .FORGET_PASSWORD);
                                              },
                                              child: Text(
                                                getTranslated(
                                                    "forget_password",
                                                    context),
                                                style: AppTextStyles
                                                    .medium
                                                    .copyWith(
                                                  color:
                                                  ColorResources
                                                      .HEADER,
                                                  fontSize: 12,
                                                  decoration:
                                                  TextDecoration
                                                      .underline,
                                                  decorationColor:
                                                  ColorResources
                                                      .HEADER,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                          ],
                                        ),*/
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(
                                            vertical: 24.h,
                                          ),
                                          child: CustomButton(
                                              text: getTranslated(
                                                  "login", context),
                                              onTap: () {
                                                if (_formKey
                                                    .currentState!
                                                    .validate()) {
                                                  provider.logIn();
                                                }
                                              },
                                              isLoading:
                                              provider.isLogin),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              getTranslated(
                                                  "do_not_have_acc",
                                                  context),
                                              textAlign:
                                              TextAlign.end,
                                              style: AppTextStyles
                                                  .medium
                                                  .copyWith(
                                                  color:
                                                  ColorResources
                                                      .TITLE,
                                                  fontSize: 16,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                CustomNavigator.push(
                                                    Routes.REGISTER,
                                                    clean: true);
                                                provider.clear();
                                              },
                                              child: Text(
                                                " ${getTranslated("signup_now", context)}",
                                                textAlign:
                                                TextAlign.start,
                                                style: AppTextStyles
                                                    .medium
                                                    .copyWith(
                                                  color:
                                                  ColorResources
                                                      .HEADER,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            CustomNavigator.push(
                                                Routes.MAIN_PAGE,clean: true);
                                            provider.clear();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 12.h),
                                            child: Text(
                                              getTranslated(
                                                  "login_as_a_guest",
                                                  context),
                                              textAlign:
                                              TextAlign.center,
                                              style: AppTextStyles
                                                  .semiBold
                                                  .copyWith(
                                                  fontSize: 14,
                                                  color: ColorResources
                                                      .HINT_COLOR),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                // customImageIcon(
                //     imageName: Images.logo, height: 140, width: 160),
              ],
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_DEFAULT.h,
            ),
          ],
        ),
      ),
    ));
  }
}
