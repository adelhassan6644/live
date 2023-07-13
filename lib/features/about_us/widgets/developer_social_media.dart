import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/components/custom_images.dart';

class DeveloperSocialMedia extends StatelessWidget {
  const DeveloperSocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.h),

      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimensions.PADDING_SIZE_DEFAULT.w,
          ),
          customContainerSvgIcon(
              imageName: SvgImages.faceBook,
              height: 50.0,
              width: 50.0,
              radius: 100,
              withShadow: true,
              color: ColorResources.WHITE_COLOR),
          const SizedBox(
            width: 16,
          ),
          customContainerSvgIcon(
              imageName: SvgImages.instagram,
              height: 50.0,
              width: 50.0,
              radius: 100,
              withShadow: true,
              color: ColorResources.WHITE_COLOR),
          const SizedBox(
            width: 16,
          ),
          customContainerSvgIcon(
              imageName: SvgImages.twitter,
              height: 50.0,
              width: 50.0,
              radius: 100,
              withShadow: true,
              color: ColorResources.WHITE_COLOR),  const SizedBox(
            width: 16,
          ),

          customContainerSvgIcon(
              imageName: SvgImages.tiktok,
              height: 50.0,
              width: 50.0,
              radius: 100,
              withShadow: true,
              color: ColorResources.WHITE_COLOR),
        ],
      ),
    );
  }
}
