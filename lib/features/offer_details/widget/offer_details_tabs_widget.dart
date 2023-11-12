import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/components/tab_widget.dart';
import 'package:live/features/offer_details/provider/offer_details_provider.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../main_widgets/maps_sheet.dart';

class OfferDetailsTabsWidget extends StatelessWidget {
  const OfferDetailsTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferDetailsProvider>(builder: (_, provider, child) {
      return Column(
        children: [
          Row(
            children: List.generate(
                provider.tabs.length,
                (index) => Expanded(
                      child: TabWidget(
                        title: getTranslated(provider.tabs[index], context),
                        isSelected: provider.selectedTab == index,
                        onTab: () => provider.onSelectTab(index),
                        innerHPadding: 2,
                        expand: true,
                      ),
                    )),
          ),
          SizedBox(
            height: 16.h,
          ),
          if (provider.selectedTab == 0)
            HtmlWidget(provider.model?.terms ?? ""),
          if (provider.selectedTab == 1)
            Column(
              children: [
                Row(
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
                        provider.model?.placeDetails?.address ?? "",
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL.h),
                  child: InkWell(
                    onTap: () async {
                      final placeItem = provider.model?.placeDetails;
                      MapsSheet.show(
                        context: context,
                        onMapTap: (map) {
                          Navigator.pop(context);
                          map.showMarker(
                            coords: Coords(provider.model!.placeDetails!.lat!,
                                provider.model!.placeDetails!.long!),
                            title: provider.model!.placeDetails!.name!,
                          );
                        },
                      );
                      // await launch(
                      //     'https://www.google.com/maps/search/?api=1&query=${provider.model?.placeDetails?.lat},${provider.model?.placeDetails?.long}');
                    },
                    child: Text(
                      getTranslated("check_location_on_map", context),
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: ColorResources.SECOUND_PRIMARY_COLOR),
                    ),
                  ),
                )
              ],
            ),
          if (provider.selectedTab == 2)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_SMALL.h),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 5,
                            blurRadius: 10)
                      ]),
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
                              path: provider.model?.placeDetails?.phone,
                            );
                            launchUrl(launchUri);
                          },
                          child: Text(
                            provider.model?.placeDetails?.phone ?? "",
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
                Padding(
                  padding:
                      EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      spacing: 16.w,
                      runSpacing: 16.h,
                      children: [
                        if (provider.model?.placeDetails?.facebook != null)
                          customContainerSvgIcon(
                              imageName: SvgImages.faceBook,
                              imageColor: ColorResources.HEADER,
                              height: 42.0,
                              width: 42.0,
                              radius: 100,
                              withShadow: true,
                              color: ColorResources.WHITE_COLOR,
                              onTap: () async {
                                launchUrl(
                                    Uri.parse(provider
                                        .model!.placeDetails!.facebook!),
                                    mode: LaunchMode.externalApplication);
                              }),
                        if (provider.model?.placeDetails?.instagram != null)
                          customContainerSvgIcon(
                              imageName: SvgImages.instagram,
                              imageColor: ColorResources.HEADER,
                              height: 42.0,
                              width: 42.0,
                              radius: 100,
                              withShadow: true,
                              color: ColorResources.WHITE_COLOR,
                              onTap: () async {
                                launchUrl(
                                    Uri.parse(provider
                                        .model!.placeDetails!.instagram!),
                                    mode: LaunchMode.externalApplication);
                              }),
                        if (provider.model?.placeDetails?.twitter != null)
                          customContainerSvgIcon(
                              imageName: SvgImages.twitter,
                              imageColor: ColorResources.HEADER,
                              height: 42.0,
                              width: 42.0,
                              radius: 100,
                              withShadow: true,
                              color: ColorResources.WHITE_COLOR,
                              onTap: () async {
                                launchUrl(
                                    Uri.parse(
                                        provider.model!.placeDetails!.twitter!),
                                    mode: LaunchMode.externalApplication);
                              }),
                        if (provider.model?.placeDetails?.tiktok != null)
                          customContainerSvgIcon(
                              imageName: SvgImages.tiktok,
                              imageColor: ColorResources.HEADER,
                              height: 42.0,
                              width: 42.0,
                              radius: 100,
                              withShadow: true,
                              onTap: () async {
                                launchUrl(
                                    Uri.parse(
                                        provider.model!.placeDetails!.tiktok!),
                                    mode: LaunchMode.externalApplication);
                              },
                              color: ColorResources.WHITE_COLOR),
                        if (provider.model?.placeDetails?.whatsapp != null)
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
                                    "whatsapp://send?phone=${provider.model!.placeDetails!.whatsapp}");
                              }),
                        if (provider.model?.placeDetails?.snapChat != null)
                          customContainerSvgIcon(
                              imageName: SvgImages.snapchat,
                              imageColor: ColorResources.HEADER,
                              height: 42.0,
                              width: 42.0,
                              radius: 100,
                              withShadow: true,
                              color: ColorResources.WHITE_COLOR,
                              onTap: () async {
                                launchUrl(
                                    Uri.parse(provider
                                        .model!.placeDetails!.snapChat!),
                                    mode: LaunchMode.externalApplication);
                              }),

                        ///Website
                        if (provider.model?.placeDetails?.website != null)
                          customContainerSvgIcon(
                              imageName: SvgImages.global,
                              imageColor: ColorResources.HEADER,
                              height: 42.0,
                              width: 42.0,
                              radius: 100,
                              withShadow: true,
                              onTap: () async {
                                launchUrl(
                                    Uri.parse(
                                        provider.model!.placeDetails!.website!),
                                    mode: LaunchMode.externalApplication);
                              },
                              color: ColorResources.WHITE_COLOR),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    });
  }
}
