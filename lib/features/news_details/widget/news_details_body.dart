import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/components/animated_widget.dart';
import 'package:live/features/offer_details/provider/offer_details_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/news_details_provider.dart';

class NewsDetailsBody extends StatefulWidget {
  const NewsDetailsBody({super.key});

  @override
  State<NewsDetailsBody> createState() => _NewsDetailsBodyState();
}

class _NewsDetailsBodyState extends State<NewsDetailsBody> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        Provider.of<NEwsDetailsProvider>(context, listen: false)
            .scroll(controller));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NEwsDetailsProvider>(builder: (_, provider, child) {
      return Expanded(
        child: ListAnimator(
          controller: controller,
          data: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Row(
                children: [

                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            provider.model?.title ??
                                "title ",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 16, color: ColorResources.TITLE)),

                      ],
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.black.withOpacity(0.1),
                  //           spreadRadius: 2,
                  //           blurRadius: 2,
                  //           offset: const Offset(1, 1))
                  //     ],
                  //     borderRadius: BorderRadius.circular(30),
                  //   ),
                  //   child: customContainerSvgIcon(
                  //       imageName: SvgImages.share,
                  //       imageColor: ColorResources.SECOUND_PRIMARY_COLOR,
                  //       color: Colors.white,
                  //       width: 40,
                  //       height: 40,
                  //       onTap: () {
                  //         provider.shareOffer(provider.model!);
                  //       }),
                  // ),
                ],
              ),
            ),


            HtmlWidget(
              provider.model?.content ??
                  "",
              textStyle:
              AppTextStyles.medium.copyWith(
                fontSize: 16,
                color: ColorResources
                    .DETAILS_COLOR,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              children: [
                customImageIconSVG(
                    imageName:
                    SvgImages.location,
                    height: 20,
                    width: 20,
                    color:
                    ColorResources.TITLE),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Text(
                    provider.model?.address ??
                        "address",
                    maxLines: 1,
                    style: AppTextStyles.medium
                        .copyWith(
                        fontSize: 16,
                        overflow:
                        TextOverflow
                            .ellipsis,
                        color:
                        ColorResources
                            .TITLE),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            SizedBox(height: 16.h),


          ],
        ),
      );
    });
  }
}
