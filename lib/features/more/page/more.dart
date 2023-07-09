import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/features/more/widgets/logout_button.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_page/provider/main_page_provider.dart';
import '../widgets/more_button.dart';
import '../widgets/profile_card.dart';

class More extends StatelessWidget {
  const More({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final ZoomDrawerController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
            Dimensions.PADDING_SIZE_DEFAULT,
            (Dimensions.PADDING_SIZE_DEFAULT + context.toPadding),
            Dimensions.PADDING_SIZE_DEFAULT,
            Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          children: [
            const ProfileCard(),
            MoreButton(
              title: getTranslated("dashboard", context),
              icon: SvgImages.homeIcon,
              onTap: () {
                controller.toggle!();
                provider.updateDashboardIndex(0);
              },
            ),
            MoreButton(
              title: getTranslated("profile", context),
              icon: SvgImages.userIcon,
              onTap: () {
                controller.toggle!();
                provider.updateDashboardIndex(1);
              },
            ),
            // MoreButton(
            //   title: getTranslated("change_password", context),
            //   icon: SvgImages.lockIcon,
            //   onTap: () {
            //     controller.toggle!();
            //     CustomNavigator.push(Routes.CHANGE_PASSWORD);
            //   },
            // ),
            MoreButton(
              title: getTranslated("favourites", context),
              icon: SvgImages.heartIcon,
              onTap: () {
                controller.toggle!();
                provider.updateDashboardIndex(3);
              },
            ),
            MoreButton(
              title: getTranslated("contact_with_us", context),
              icon: SvgImages.mailIcon,
              onTap: () {
                controller.toggle!();
              },
            ),
            MoreButton(
              title: getTranslated("terms_conditions", context),
              icon: SvgImages.file,
              onTap: () {
                controller.toggle!();
              },
            ),
            MoreButton(
              title: getTranslated("about_us", context),
              icon: SvgImages.aboutUsIcon,
              onTap: () {
                controller.toggle!();
              },
            ),
            const Expanded(child: SizedBox()),
            const LogoutButton(),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }
}
