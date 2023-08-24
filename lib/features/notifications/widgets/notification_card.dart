
import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/extensions.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../model/notifications_model.dart';
import '../provider/notifications_provider.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    this.notification,
    this.withBorder = true,
  }) : super(key: key);
  final NotificationItem? notification;
  final bool withBorder;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        CustomNavigator.push(Routes.PLACE_DETAILS, arguments:widget.notification?.notificationBody?.offer_id);
        if (widget.notification?.isRead != true) {
          sl<NotificationsProvider>()
              .readNotification(widget.notification?.id ?? 0);
          setState(() => widget.notification?.isRead = true);

        }
      },
      child: Container(
        width: context.width,
        height: 90,
        margin: EdgeInsets.only(bottom: 6.h),
        padding: EdgeInsets.symmetric(
            horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(20),
            boxShadow:widget.notification!.isRead !=true ?null: [
              BoxShadow(
                  offset: const Offset(2, 2),
                  color: Colors.black.withOpacity(0.03),
                  spreadRadius: 5,
                  blurRadius: 10)
            ]),
        child: Row(
          children: [
            CustomNetworkImage.circleNewWorkImage(
              radius: 40.5,
              padding: 0,

              backGroundColor: ColorResources.SECOUND_PRIMARY_COLOR,
              image:

              widget.notification?.notificationBody?.image,
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(widget.notification?.notificationBody?.message ?? "",
                            maxLines: 5,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium
                                .copyWith(fontSize: 16, color: widget.notification?.isRead == true
                                ? ColorResources.DETAILS_COLOR
                                : ColorResources.SUBTITLE)),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Align(
                    child: Text(
                        widget.notification?.createdAt
                                ?.dateFormat(format: "EEE dd/mm") ??
                            "",
                        style: AppTextStyles.regular
                            .copyWith(fontSize: 14, color: ColorResources.DETAILS_COLOR)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
