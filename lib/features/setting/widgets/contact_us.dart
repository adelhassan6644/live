import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_button.dart';
import '../../contact_with_us/provider/contact_provider.dart';

class ContactUS extends StatelessWidget {
  const ContactUS({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(

          children: [
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
        ),
      );
    });
  }
}
