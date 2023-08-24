
import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../data/config/di.dart';
import '../provider/notifications_provider.dart';
import '../repo/notifications_repo.dart';
import '../widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationsProvider(notificationsRepo: sl<NotificationsRepo>())..getNotifications(),
      child: Scaffold(

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Text(getTranslated("notifications", context),
                  style: AppTextStyles.semiBold
                      .copyWith(fontSize: 24, color: ColorResources.HEADER)),
            ),
            Expanded(child:
                Consumer<NotificationsProvider>(builder: (_, provider, child) {
              return Container(

                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                      // color: Styles.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(24)),
                  child: provider.isLoading
                      ? ListAnimator(
                          data: List.generate(
                              10,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: Dimensions.PADDING_SIZE_SMALL),
                                    child: CustomShimmerContainer(
                                      width: context.width,
                                      height: 60,
                                      radius: 12,
                                    ),
                                  )))
                      : provider.model != null &&
                              provider.model?.data != null &&
                              provider.model!.data!.isNotEmpty
                          ? RefreshIndicator(
                              color: ColorResources.PRIMARY_COLOR,
                              onRefresh: () async {
                                sl<NotificationsProvider>().getNotifications();
                              },
                              child: Column(
                                children: [
                                  ListAnimator(
                                      data: List.generate(
                                          provider.model?.data?.length ?? 0,
                                          (index) => Dismissible(
                                                background: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                      width: 100.w,
                                                      height: 30.h,
                                                      text: getTranslated(
                                                          "delete", context),
                                                      svgIcon: SvgImages.card,
                                                      iconSize: 12,
                                                      iconColor:
                                                      ColorResources.IN_ACTIVE,
                                                      textColor:
                                                      ColorResources.IN_ACTIVE,
                                                      backgroundColor: ColorResources
                                                          .IN_ACTIVE
                                                          .withOpacity(0.12),
                                                    ),
                                                  ],
                                                ),
                                                key: ValueKey(index),
                                                confirmDismiss:
                                                    (DismissDirection
                                                        direction) async {
                                                  provider.deleteNotification(
                                                      provider
                                                              .model
                                                              ?.data?[index]
                                                              .id ??
                                                          0);
                                                  return false;
                                                },
                                                child: NotificationCard(
                                                  withBorder: index != 9,
                                                  notification: provider
                                                      .model?.data?[index],
                                                ),
                                              ))),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              color: ColorResources.PRIMARY_COLOR,
                              onRefresh: () async {
                                sl<NotificationsProvider>().getNotifications();
                              },
                              child:  Column(
                                children: [
                                  Expanded(
                                    child: ListAnimator(data: [
                                      EmptyState(
                                        txt: getTranslated("no_notifications", context),
                                        txtColor:
                                        ColorResources.DISABLED,
                                        imgHeight: 250,
                                        imgWidth: 250,
                                        img: Images.emptyNotifcations,
                                        isSvg: false,
                                        spaceBtw: 50,
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ));
            }))
          ],
        ),
      ),
    );
  }
}
