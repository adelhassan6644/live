import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget customImageIcon(
    {required String imageName,
    double? width,
    double? height,
    BoxFit fit = BoxFit.fill,
    color}) {
  return Image.asset(
    imageName,
    color: color,
    fit: BoxFit.fill,
    width: width ?? 30,
    height: height ?? 25,
  );
}

Widget customCircleSvgIcon(
    {String? title,
    required String imageName,
    Function? onTap,
    color,
    width,
    height,
    radius}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor:
              color ?? ColorResources.PRIMARY_COLOR.withOpacity(0.1),
          radius: radius ?? 24.w,
          child: SvgPicture.asset(
            imageName,
          ),
        ),
        Visibility(
          visible: title != null,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                title ?? "",
                style: AppTextStyles.medium.copyWith(
                    color: ColorResources.PRIMARY_COLOR, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget customContainerSvgIcon(
    {required String imageName,
    Function? onTap,
    color,
    width,
    height,
    radius}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: color ?? ColorResources.PRIMARY_COLOR.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radius ?? 12)),
      // backgroundColor:
      // radius: radius ?? 24.w,

      child: SvgPicture.asset(
        imageName,
      ),
    ),
  );
}

Widget customImageIconSVG(
    {required String imageName,
    Color? color,
    double? height,
    double? width,
    Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SvgPicture.asset(
      imageName,
      color: color,
      height: height,
      width: width,
    ),
  );
}
