import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:live/components/custom_images.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../../app/core/utils/text_styles.dart';
import '../../../../app/localization/localization/language_constant.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE.w),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            Images.loginImage,
          ),
          fit: BoxFit.fitWidth,
        )),
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 75.h),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: 30.h),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25)),
                      child:
                          Consumer<AuthProvider>(builder: (_, provider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 30.h, 0, 24.h),
                              child: Text(
                                getTranslated("login_header", context),
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 28,
                                    color: ColorResources.WHITE_COLOR),
                              ),
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      controller: provider.mailTEC,
                                      hint: getTranslated("mail", context),
                                      inputType: TextInputType.emailAddress,
                                      valid: Validations.mail,
                                      pSvgIcon: SvgImages.mailIcon,
                                    ),
                                    CustomTextFormField(
                                      keyboardAction: TextInputAction.done,
                                      controller: provider.passwordTEC,
                                      hint: getTranslated("password", context),
                                      inputType: TextInputType.visiblePassword,
                                      valid: Validations.password,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CustomButton(
                                        text: getTranslated("login", context),
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            provider.logIn();
                                          }
                                        },
                                        isLoading: provider.isLoading),
                                  ],
                                )),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              customImageIcon(imageName: Images.logo, height: 140, width: 160),
            ],
          ),
        ),
      ),
    );
  }
}
