import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/app/localization/localization/language_constant.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../../../main_page/provider/main_page_provider.dart';
import '../../auth/provider/auth_provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorResources.WHITE_COLOR),
      child: InkWell(
        onTap: () {
          sl<AuthProvider>().logOut();
          sl<MainPageProvider>().updateIsOpen(false);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customImageIconSVG(
                imageName: SvgImages.logout,
                height: 20,
                width: 20,
                color: ColorResources.ERORR_COLOR),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(getTranslated("logout", context),
                        maxLines: 1,
                        style: AppTextStyles.w500.copyWith(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            color: ColorResources.ERORR_COLOR)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
