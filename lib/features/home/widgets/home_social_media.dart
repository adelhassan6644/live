import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/components/custom_images.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../setting/provider/setting_provider.dart';

class HomeSocialMedia extends StatelessWidget {
  final bool fromDashBoard;
  const HomeSocialMedia({Key? key, this.fromDashBoard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (_, provider, child) {
      return Center(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: provider.isLoading
                ? List.generate(
                    4,
                    (index) => Padding(
                          padding: EdgeInsets.only(
                              left: 16,
                              right: index == 0
                                  ? Dimensions.PADDING_SIZE_DEFAULT.w
                                  : 0),
                          child: const CustomShimmerCircleImage(
                            diameter: 25,
                          ),
                        ))
                : [
                    SizedBox(
                      width: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    if (provider.model?.data?.homeFacebook != null)
                      customContainerSvgIcon(
                          imageName: SvgImages.faceBook,
                          height: 40,
                          width: 40,
                          imageColor: ColorResources.HEADER,
                          radius: 100,
                          withShadow: false,
                          color: Colors.transparent,
                          onTap: () async {
                            launchUrl(
                                Uri.parse(
                                    provider.model?.data?.homeFacebook ?? ""),
                                mode: LaunchMode.externalApplication);
                          }),
                    if (provider.model?.data?.homeInstagram != null)
                      customContainerSvgIcon(
                          imageName: SvgImages.instagram,
                          height: 40,
                          width: 40,
                          imageColor: ColorResources.HEADER,
                          radius: 100,
                          withShadow: false,
                          color: Colors.transparent,
                          onTap: () async {
                            launchUrl(
                                Uri.parse(
                                    provider.model?.data?.homeInstagram ?? ""),
                                mode: LaunchMode.externalApplication);
                          }),
                    if (provider.model?.data?.homeTwitter != null)
                      customContainerSvgIcon(
                          imageName: SvgImages.twitter,
                          height: 40,
                          width: 40,
                          imageColor: ColorResources.HEADER,
                          radius: 100,
                          withShadow: false,
                          color: Colors.transparent,
                          onTap: () async {
                            launchUrl(
                                Uri.parse(
                                    provider.model?.data?.homeTwitter ?? ""),
                                mode: LaunchMode.externalApplication);
                          }),
                    if (provider.model?.data?.homeTiktok != null)
                      customContainerSvgIcon(
                          imageName: SvgImages.tiktok,
                          height: 40,
                          width: 40,
                          imageColor: ColorResources.HEADER,
                          radius: 100,
                          withShadow: false,
                          color: Colors.transparent,
                          onTap: () async {
                            launchUrl(
                                Uri.parse(
                                    provider.model?.data?.homeTiktok ?? ""),
                                mode: LaunchMode.externalApplication);
                          }),
                    if (provider.model?.data?.homeSnapchat != null)
                      customContainerSvgIcon(
                          imageName: SvgImages.snapchat,
                          height: 40,
                          width: 40,
                          imageColor: ColorResources.HEADER,
                          radius: 100,
                          withShadow: false,
                          color: Colors.transparent,
                          onTap: () async {
                            launchUrl(
                                Uri.parse(
                                    provider.model?.data?.homeSnapchat ?? ""),
                                mode: LaunchMode.externalApplication);
                          }),
                    if (provider.model?.data?.homeWebsite != null)
                      customContainerSvgIcon(
                          imageName: SvgImages.website,
                          height: 40,
                          width: 40,
                          imageColor: ColorResources.HEADER,
                          radius: 100,
                          withShadow: false,
                          color: Colors.transparent,
                          onTap: () async {
                            launchUrl(
                                Uri.parse(
                                    provider.model?.data?.homeWebsite ?? ""),
                                mode: LaunchMode.externalApplication);
                          }),
                    if (provider.model?.data?.homeWebsite != null)
                      customContainerSvgIcon(
                          imageName: SvgImages.whatsApp,
                          height: 40,
                          width: 40,
                          imageColor: ColorResources.HEADER,
                          radius: 100,
                          withShadow: false,
                          color: Colors.transparent,
                          onTap: () async {
                            launchUrl(
                                Uri.parse(
                                    "https://wa.me/${provider.model?.data?.homeWatsApp}" ??
                                        ""),
                                mode: LaunchMode.externalApplication);
                          }),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
          ),
        ),
      );
    });
  }
}
