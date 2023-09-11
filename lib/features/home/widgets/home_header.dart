import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.PADDING_SIZE_DEFAULT.h,
          ),
          Text(
            "هلا فيك فى احياء الحمدانية",
            style: AppTextStyles.bold.copyWith(
                fontSize: 26, color: ColorResources.SECOUND_PRIMARY_COLOR),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            " خلنا نعرفك على اماكن واخبار وعروض الحى",
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 20, color: ColorResources.TITLE),
          ),
        ],
      ),
    );
  }
}
