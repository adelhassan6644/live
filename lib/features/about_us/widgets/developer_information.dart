import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_text_form_field.dart';

class DeveloperInformation extends StatelessWidget {
  const DeveloperInformation({Key? key}) : super(key: key);

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
          Text(
            getTranslated("contact_with_us", context),
            style: AppTextStyles.medium.copyWith(
                color: ColorResources.HEADER,
                fontSize: 16,
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            height: 18.h,
          ),
          CustomTextFormField(
            hint: getTranslated("mail", context),
            inputType: TextInputType.emailAddress,
            pSvgIcon: SvgImages.mailIcon,
            read: true,
            addBorder: true,
          ),
          CustomTextFormField(
            hint: getTranslated("mail", context),
            inputType: TextInputType.emailAddress,
            pSvgIcon: SvgImages.phoneCallIcon,
            read: true,
            addBorder: true,
          ),
        ],
      ),
    );
  }
}
