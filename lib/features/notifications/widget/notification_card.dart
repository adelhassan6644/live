import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/text_styles.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/components/custom_button.dart';
import 'package:live/features/notifications/model/notifications_model.dart';
import 'package:live/features/notifications/provider/notifications_provider.dart';
import 'package:flutter/material.dart';

import '../../../data/config/di.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {this.isRequest = false, required this.notificationItem, Key? key})
      : super(key: key);
  final bool isRequest;
  final NotificationItem notificationItem;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.notificationItem.id),
      background: Container(
        color: ColorResources.SECOUND_PRIMARY_COLOR.withOpacity(0.20),
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT.w),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) {
        sl<NotificationsProvider>()
            .deleteNotification(widget.notificationItem.id);
      },
      child: InkWell(
        onTap: () {
          sl<NotificationsProvider>()
              .readNotification(widget.notificationItem.id);
          setState(() => widget.notificationItem.isRead = true);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 16.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          decoration: BoxDecoration(
              color: widget.notificationItem.isRead == true
                  ? null
                  : ColorResources.PRIMARY_COLOR.withOpacity(0.1),
              border: Border(
                  bottom: BorderSide(
                      color: ColorResources.LIGHT_GREY_BORDER, width: 1.h))),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.notificationItem.notificationData?.message ?? "",
                  maxLines: 1,
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, overflow: TextOverflow.ellipsis),
                ),
              ),
              if (widget.isRequest)
                SizedBox(
                  width: 40.w,
                ),
              if (widget.isRequest)
                CustomButton(
                  onTap: () {},
                  text: getTranslated("preview", context),
                  radius: 100,
                  width: 70,
                  textSize: 12,
                  height: 30,
                )
            ],
          ),
        ),
      ),
    );
  }
}
