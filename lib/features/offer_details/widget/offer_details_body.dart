import 'package:flutter/material.dart';
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
import '../../place_details/provider/place_details_provider.dart';

class OfferDetailsBody extends StatelessWidget {
  const OfferDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferDetailsProvider>(builder: (_, provider, child) {
      return Expanded(
          child: ListAnimator(
        data: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
            child: Row(
              children: [
                CustomNetworkImage.circleNewWorkImage(
                    color: ColorResources.HINT_COLOR,
                    image: provider.model?.logo ?? "",
                    radius: 28),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(provider.model?.name ?? "Store Name",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 16, color: ColorResources.TITLE)),
                      Row(
                        children: [
                          customImageIconSVG(
                              imageName: SvgImages.fillStar,
                              height: 18,
                              width: 18),
                          Text(" ${provider.model?.rate ?? 0}",
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorResources.DETAILS_COLOR)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(1, 1))
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: customContainerSvgIcon(
                      imageName: SvgImages.share,
                      imageColor: ColorResources.SECOUND_PRIMARY_COLOR,
                      color: Colors.white,
                      width: 40,
                      height: 40,
                      onTap: () {
                        provider.shareOffer(provider.model!);
                      }),
                ),
              ],
            ),
          ),

          ///Store Offer
          Text(provider.model?.title ?? "",
              style: AppTextStyles.medium
                  .copyWith(fontSize: 16, color: ColorResources.TITLE)),
          SizedBox(height: 8.h),

          ///Store Offer
          Text(provider.model?.description ?? "",
              style: AppTextStyles.regular
                  .copyWith(fontSize: 14, color: ColorResources.TITLE)),

          ///Offer Prices
          Padding(
            padding: EdgeInsets.only(
                bottom: 8.h, top: Dimensions.PADDING_SIZE_DEFAULT.h),
            child: Row(
              children: [
                Text(
                    "${provider.model?.price ?? 0} ${getTranslated("sar", context)}",
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: ColorResources.IN_ACTIVE)),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(
                      "${provider.model?.discountPrice ?? 0} ${getTranslated("sar", context)}",
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14, color: ColorResources.ACTIVE)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color:
                          ColorResources.SECOUND_PRIMARY_COLOR.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text("${provider.model?.percentage ?? 0} %",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 14, color: ColorResources.TITLE)),
                )
              ],
            ),
          ),

          ///Expired Date of Offer
          Text(
              "${getTranslated("expired_at", context)} ${provider.model?.expiredDate ?? ""}",
              style: AppTextStyles.medium
                  .copyWith(fontSize: 16, color: ColorResources.TITLE)),
        ],
      ));
    });
  }
}
