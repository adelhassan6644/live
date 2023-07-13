import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';

class DeveloperDescription extends StatelessWidget {
  const DeveloperDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: ColorResources.WHITE_COLOR,
          border: Border.all(color: ColorResources.LIGHT_BORDER_COLOR)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                getTranslated("about_us", context).replaceAll("ا", " "),
                style: AppTextStyles.medium.copyWith(
                    color: ColorResources.HEADER,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                "Software Cloud 2",
                style: AppTextStyles.medium.copyWith(
                    color: const Color(0xFFF8A14E),
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          SizedBox(
            height: 18.h,
          ),
          Text(
            "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النصالعربى، حيث يمكنك أن تولد مثل هذا النص أوالعديد من النصوص الأخرى إضافة إلى زيادة عددالحروف التى يولدها التطبيق. إذا كنت تحتاج إلىعدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة",
            style: AppTextStyles.light.copyWith(
                color: ColorResources.DETAILS_COLOR,
                fontSize: 14,
                overflow: TextOverflow.ellipsis),
            maxLines: 10,
          ),
        ],
      ),
    );
  }
}
