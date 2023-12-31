import 'package:flutter/material.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:live/main_models/places_model.dart';
import 'package:live/features/place_details/widgets/place_feedbacks.dart';
import 'package:live/features/place_details/widgets/place_offers_widget.dart';
import 'package:live/features/place_details/widgets/rate_place.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../provider/place_details_provider.dart';

class PlaceDetailsWidget extends StatelessWidget {
  final PlaceItem placeItem;
  const PlaceDetailsWidget({super.key, required this.placeItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Text(
              placeItem.category ?? "",
              style: AppTextStyles.light.copyWith(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  color: placeItem.nameColor?.toColor),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    placeItem.name ?? "",
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 19,
                        overflow: TextOverflow.ellipsis,
                        color: ColorResources.TITLE),
                    maxLines: 2,
                  ),
                ),
                Consumer<PlaceDetailsProvider>(builder: (context, provider, w) {
                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(1, 1))
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: customContainerSvgIcon(
                        imageName: SvgImages.share,
                        imageColor: ColorResources.SECOUND_PRIMARY_COLOR,
                        color: Colors.white,
                        width: 40,
                        height: 40,
                        onTap: () {
                          provider.sharePlace(placeItem);
                        }),
                  );
                }),
                const SizedBox(
                  width: 5,
                ),
                Consumer<PlaceDetailsProvider>(builder: (context, provider, w) {
                  return CustomButton(
                    text: !provider.isFollow
                        ? getTranslated("follow", context)
                        : getTranslated("un_follow", context),
                    width: provider.isFollow ? 150 : 115,
                    onTap: () {
                      provider.followPlace(placeItem.id);
                    },
                    height: 35,
                    withBorderColor: false,
                    withShadow: true,
                    iconSize: 15,
                    textColor: ColorResources.SECOUND_PRIMARY_COLOR,
                    assetIcon: Images.add,
                    iconColor: ColorResources.SECOUND_PRIMARY_COLOR,
                    backgroundColor: ColorResources.WHITE_COLOR,
                    textSize: 14,
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 4.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.location,
                    height: 18,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Text(
                    placeItem.address ?? "",
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      color: const Color(0xFF656565),
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.phoneIcon,
                    height: 16,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: placeItem.phone,
                      );
                      launchUrl(launchUri);
                    },
                    child: Text(
                      placeItem.phone ?? "",
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        color: const Color(0xFF656565),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: placeItem.description != null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   getTranslated("description", context),
                    //   style: AppTextStyles.medium.copyWith(
                    //     fontSize: 16,
                    //     color: ColorResources.TITLE,
                    //   ),
                    // ),
                    SizedBox(height: 4.w),
                    Text(
                      placeItem.description ?? "",
                      style: AppTextStyles.light.copyWith(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: ColorResources.DETAILS_COLOR,
                      ),
                      maxLines: 10,
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 6.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            child: Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 16.w,
                runSpacing: 16.h,
                children: [
                  ///Facebook
                  if (placeItem.facebook != null)
                    customContainerSvgIcon(
                        imageName: SvgImages.faceBook,
                        imageColor: ColorResources.HEADER,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(Uri.parse(placeItem.facebook!),
                              mode: LaunchMode.externalApplication);
                        }),

                  ///Instagram
                  if ((placeItem.instagram != null))
                    customContainerSvgIcon(
                        imageName: SvgImages.instagram,
                        imageColor: ColorResources.HEADER,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(Uri.parse(placeItem.instagram!),
                              mode: LaunchMode.externalApplication);
                        }),

                  ///Twitter
                  if ((placeItem.twitter != null))
                    customContainerSvgIcon(
                        imageName: SvgImages.twitter,
                        imageColor: ColorResources.HEADER,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(Uri.parse(placeItem.twitter!),
                              mode: LaunchMode.externalApplication);
                        }),

                  ///Tiktok
                  if ((placeItem.tiktok != null))
                    customContainerSvgIcon(
                        imageName: SvgImages.tiktok,
                        imageColor: ColorResources.HEADER,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        onTap: () async {
                          launchUrl(Uri.parse(placeItem.tiktok!),
                              mode: LaunchMode.externalApplication);
                        },
                        color: ColorResources.WHITE_COLOR),

                  ///WhatsApp
                  if ((placeItem.whatsapp != null))
                    customContainerSvgIcon(
                        imageName: SvgImages.whatsApp,
                        imageColor: ColorResources.HEADER,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          await launch(
                              "whatsapp://send?phone=${placeItem.whatsapp}");
                        }),

                  ///SnapChat
                  if ((placeItem.snapChat != null))
                    customContainerSvgIcon(
                        imageName: SvgImages.snapchat,
                        imageColor: ColorResources.HEADER,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(Uri.parse(placeItem.snapChat!),
                              mode: LaunchMode.externalApplication);
                        }),

                  ///Website
                  if ((placeItem.website != null))
                    customContainerSvgIcon(
                        imageName: SvgImages.global,
                        imageColor: ColorResources.HEADER,
                        height: 42.0,
                        width: 42.0,
                        radius: 100,
                        withShadow: true,
                        onTap: () async {
                          launchUrl(Uri.parse(placeItem.website!),
                              mode: LaunchMode.externalApplication);
                        },
                        color: ColorResources.WHITE_COLOR),
                ],
              ),
            ),
          ),

          const PlaceOffersWidget(),

          ///Rate
          const RatePlace(),

          ///FeedBacks
          const PlaceFeedBacks()
        ],
      ),
    );
  }
}

class PlaceDetailsWidgetShimmer extends StatelessWidget {
  const PlaceDetailsWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      decoration: const BoxDecoration(
          color: ColorResources.WHITE_COLOR,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomShimmerContainer(
            width: 100,
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomShimmerContainer(
                  width: 100,
                  height: 15,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                CustomShimmerContainer(
                  width: 100,
                  height: 35,
                  radius: 100,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.location,
                    height: 18,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                const CustomShimmerContainer(
                  width: 200,
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.phoneIcon,
                    height: 16,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                const CustomShimmerContainer(
                  width: 200,
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomShimmerContainer(
                  width: 100,
                  height: 15,
                ),
                SizedBox(
                  height: 4.w,
                ),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: CustomShimmerContainer(
                      width: context.width,
                      height: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          const CustomShimmerContainer(
            width: 100,
            height: 35,
            radius: 100,
          ),
          SizedBox(
            height: 24.h,
          )
        ],
      ),
    );
  }
}
