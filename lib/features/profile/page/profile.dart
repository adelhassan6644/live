import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/text_styles.dart';
import 'package:live/features/profile/widgets/profile_image_widget.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/validation.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../provider/profile_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 160 + context.toPadding,
                  width: context.width,
                  margin: const EdgeInsets.only(bottom: 68),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.profileBGImage),
                          fit: BoxFit.fitHeight)),
                  child: const SizedBox(),
                ),
                const ProfileImageWidget(withEdit: true)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
             provider.profileModel?.name?? "Mohamed Ahmed",
              style: AppTextStyles.w500
                  .copyWith(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: ColorResources.WHITE_COLOR,
                  border: Border.all(color: ColorResources.LIGHT_BORDER_COLOR)),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getTranslated("personal_information", context),
                              style: AppTextStyles.w500.copyWith(
                                  color: ColorResources.HEADER,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              provider.updateProfile();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: ColorResources.WHITE_COLOR,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(1, 1))
                                  ]),
                              child: Row(
                                children: [
                                  Text(
                                    getTranslated("edit", context),
                                    style: AppTextStyles.w500.copyWith(
                                        color: ColorResources
                                            .SECOUND_PRIMARY_COLOR,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  customImageIconSVG(
                                    imageName: SvgImages.edit,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      CustomTextFormField(
                        controller: provider.nameTEC,
                        hint: getTranslated("name", context),
                        inputType: TextInputType.name,
                        valid: Validations.name,
                        pSvgIcon: SvgImages.userIcon,
                      ),
                      CustomTextFormField(
                        controller: provider.phoneTEC,
                        hint: getTranslated("phone_number", context),
                        inputType: TextInputType.phone,
                        valid: Validations.phone,
                        pSvgIcon: SvgImages.phoneIcon,
                      ),
                      CustomTextFormField(
                        controller: provider.emailTEC,
                        hint: getTranslated("mail", context),
                        inputType: TextInputType.emailAddress,
                        valid: Validations.mail,
                        pSvgIcon: SvgImages.mailIcon,
                        read: true,
                        addBorder: false,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    });
  }
}
