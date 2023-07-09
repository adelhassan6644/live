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
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/auth_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/auth_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
        child: Column(
          children: [
            const AuthAppBar(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 75.h),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(25),
                                child: BackdropFilter(
                                  filter: ui.ImageFilter.blur(
                                      sigmaX: 5.0, sigmaY: 5.0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_DEFAULT.w,
                                        vertical: 30.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Consumer<AuthProvider>(
                                        builder: (_, provider, child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 30.h, 0, 24.h),
                                            child: Text(
                                              getTranslated(
                                                  "forget_password_header",
                                                  context),
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.semiBold
                                                  .copyWith(
                                                      fontSize: 22,
                                                      color: ColorResources
                                                          .WHITE_COLOR),
                                            ),
                                          ),
                                          Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  CustomTextFormField(
                                                    controller:
                                                        provider.mailTEC,
                                                    hint: getTranslated(
                                                        "mail", context),
                                                    inputType: TextInputType
                                                        .emailAddress,
                                                    valid: Validations.mail,
                                                    pSvgIcon:
                                                        SvgImages.mailIcon,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 24.h,
                                                    ),
                                                    child: CustomButton(
                                                        text: getTranslated(
                                                            "submit", context),
                                                        onTap: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            provider
                                                                .forgetPassword();
                                                          }
                                                        },
                                                        isLoading:
                                                            provider.isForget),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            customImageIcon(
                                imageName: Images.logo,
                                height: 140,
                                width: 160),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.toPadding+24.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
