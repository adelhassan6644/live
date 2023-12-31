import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/components/custom_images.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/setting_provider.dart';

class DeveloperSocialMedia extends StatelessWidget {
  const DeveloperSocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (_, provider, child) {
      return Center(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    customContainerSvgIcon(
                        imageName: SvgImages.faceBook,
                        height: 50.0,
                        width: 50.0,
                        imageColor: ColorResources.HEADER,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(
                              Uri.parse(provider.model?.data?.facebook ?? ""),
                              mode: LaunchMode.externalApplication);
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    customContainerSvgIcon(
                        imageName: SvgImages.instagram,
                        height: 50.0,
                        width: 50.0,
                        radius: 100,
                        imageColor: ColorResources.HEADER,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(
                              Uri.parse(provider.model?.data?.instagram ?? ""),
                              mode: LaunchMode.externalApplication);
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    customContainerSvgIcon(
                        imageName: SvgImages.twitter,
                        imageColor: ColorResources.HEADER,
                        height: 50.0,
                        width: 50.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(
                              Uri.parse(provider.model?.data?.twitter ?? ""),
                              mode: LaunchMode.externalApplication);
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    customContainerSvgIcon(
                        imageName: SvgImages.tiktok,
                        imageColor: ColorResources.HEADER,
                        height: 50.0,
                        width: 50.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(
                              Uri.parse(provider.model?.data?.tiktok ?? ""),
                              mode: LaunchMode.externalApplication);
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    customContainerSvgIcon(
                        imageName: SvgImages.snapchat,
                        imageColor: ColorResources.HEADER,
                        height: 50.0,
                        width: 50.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(
                              Uri.parse(provider.model?.data?.snapchat ?? ""),
                              mode: LaunchMode.externalApplication);
                        }),
              const SizedBox(
                width: 16,
              ),
                    customContainerSvgIcon(
                        imageName: SvgImages.website,
                        imageColor: ColorResources.HEADER,
                        height: 50.0,
                        width: 50.0,
                        radius: 100,
                        withShadow: true,
                        color: ColorResources.WHITE_COLOR,
                        onTap: () async {
                          launchUrl(
                              Uri.parse(provider.model?.data?.website ?? ""),
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
