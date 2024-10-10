import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../contact_with_us/provider/contact_provider.dart';

class HomeStatistics extends StatelessWidget {
  const HomeStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<ContactProvider>(
        builder: (context, contactProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(
            height: 20,
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_DEFAULT.w
            ),
            child: Text(
              "الاحصائيات",
              style: AppTextStyles.semiBold
                  .copyWith(fontSize: 24, color: ColorResources.HEADER),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if(contactProvider.contactModel?.buildings!="null")
                sochialItem(icon: SvgImages.places, title: "${contactProvider.contactModel?.buildings} منشآت  "),

              if(contactProvider.contactModel?.downloads!="null")
                sochialItem(
                    icon: SvgImages.download, title: "${contactProvider.contactModel?.downloads} تنزيلات  "),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if(contactProvider.contactModel?.subscribers!="null")
                sochialItem(
                    icon: SvgImages.members, title: "${contactProvider.contactModel?.subscribers} مشتركين "),
              if(contactProvider.contactModel?.visits!="null")

                sochialItem(
                    icon: SvgImages.visits, title: "${contactProvider.contactModel?.visits} الزيارات "),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],);
      }
    );
  }
  Row sochialItem({required String icon, title}) {
    return Row(
      children: [
        customImageIconSVG(
          imageName: icon,
          height: 26,
          width: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: AppTextStyles.regular.copyWith(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
