import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:live/components/animated_widget.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../main_widgets/software_copyRight.dart';
import '../provider/contact_provider.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("contact_with_us", context),
          ),
          Expanded(
              child: Consumer<ContactProvider>(builder: (_, provider, child) {
            return ListAnimator(
              customPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: 24.h),
              data: [
                CustomButton(
                  text: getTranslated("mail", context),
                  svgIcon: SvgImages.mailIcon,
                  iconColor: ColorResources.WHITE_COLOR,
                  radius: 50,
                  onTap: () => provider.launchMail(),
                ),
                SizedBox(height: 18.h),
                // CustomButton(
                //   text: getTranslated("twitter", context),
                //   radius: 50,
                //   onTap: () => provider.launchTwitter(),
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
                CustomButton(
                  text: getTranslated("whatsapp", context),
                  svgIcon: SvgImages.whatsApp,
                  iconColor: ColorResources.WHITE_COLOR,
                  radius: 50,
                  onTap: () => provider.launchWhatsapp(),
                ),
                // SizedBox(
                //   height: 8.h,
                // ),
                // CustomButton(
                //   text: getTranslated("customerـservice", context),
                //   radius: 50,
                //   onTap: () => provider.launchCustomerService(),
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
              ],
            );
          })),
          const SafeArea(bottom: true, child: SoftwareCloudCopyRight())
        ],
      ),
    );
  }
}
