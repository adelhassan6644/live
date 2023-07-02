import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/features/notifications/provider/notifications_provider.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:live/navigation/routes.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../auth/login/provider/auth_provider.dart';
import '../../profile/provider/profile_provider.dart';
import 'more_button.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            color: ColorResources.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 5.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 6))
            ]),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            MoreButton(
              title: getTranslated("personal_information", context),
              icon: SvgImages.file,
              onTap: () {
                sl<ProfileProvider>().getProfile();
                CustomNavigator.push(Routes.EDIT_PROFILE, arguments: false);
              },
            ),
            Visibility(
              visible: !sl<ProfileProvider>().isDriver,
              child: MoreButton(
                title: getTranslated("followers", context),
                icon: SvgImages.addFollower,
                onTap: () {
                  CustomNavigator.push(Routes.FOLLOWERS);
                },
              ),
            ),
            MoreButton(
              title: getTranslated("archives", context),
              icon: SvgImages.bookMark,
              onTap: () => CustomNavigator.push(Routes.WISHLIST),
            ),
            MoreButton(
              title: getTranslated("notifications", context),
              icon: SvgImages.notifications,
              onTap: () {
                sl<NotificationsProvider>().getNotifications();
                CustomNavigator.push(Routes.NOTIFICATIONS);
              },
            ),
            // MoreButton(
            //   title: getTranslated("bank_data", context),
            //   icon: SvgImages.card,
            // ),
            MoreButton(
              title: sl<ProfileProvider>().isDriver
                  ? getTranslated("clients_evaluation", context)
                  : getTranslated("captain_evaluation", context),
              icon: SvgImages.rate,
              onTap: () {
                CustomNavigator.push(
                  Routes.FEEDBACK,
                );
                // CustomNavigator.push(Routes.RATE_USER,arguments: 20);
              },
            ),
            MoreButton(
              title: getTranslated("contact_with_us", context),
              icon: SvgImages.call,
              onTap: () => CustomNavigator.push(Routes.CONTACT_WITH_US),
            ),
            MoreButton(
              title: getTranslated("log_out", context),
              icon: SvgImages.logout,
              withBorder: false,
              isLogout: true,
              onTap: sl<AuthProvider>().logOut,
            ),
          ],
        ),
      ),
    );
  }
}
