import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/components/custom_images.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_network_image.dart';
import '../main_models/offers_model.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({required this.offer, super.key});
  final OfferItem offer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          CustomNavigator.push(Routes.OFFER_DETAILS, arguments: offer.id),
      child: Container(
        width: context.width*.80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: ColorResources.GREY_BORDER,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Image
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: CustomNetworkImage.containerNewWorkImage(
                    image: offer.image ?? "",
                    height: 120.h,
                    width: context.width,
                    fit: BoxFit.cover,
                    edges: true,
                    radius: 12.w,
                  ),
                ),
                CustomNetworkImage.circleNewWorkImage(
                    color: ColorResources.HINT_COLOR,
                    image: offer.placeDetails?.image ?? "",
                    radius: 38)
              ],
            ),

            ///Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Store Offer
                  Text(offer.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 16, color: ColorResources.TITLE)),

                  ///Store Name && Rate
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text("${offer.placeDetails?.name ?? "Place name"}  ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.regular.copyWith(
                                fontSize: 14,
                                color: ColorResources.DETAILS_COLOR)),
                      ),
                      customImageIconSVG(
                          imageName: SvgImages.fillStar, height: 18, width: 18),
                      Text(" ${offer.rate ?? 0}",
                          maxLines: 2,
                          style: AppTextStyles.regular.copyWith(
                              fontSize: 14,
                              color: ColorResources.DETAILS_COLOR)),
                    ],
                  ),

                  ///Offer Prices
                  Visibility(
                    visible: (offer.price!=null),
                    child: Text("${offer.price ?? 0} ${getTranslated("sar", context)}",
                        style: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: ColorResources.IN_ACTIVE)),
                  ),

                  Visibility(visible: (offer.discountPrice!=null),
                    child: Text(
                        "${offer.discountPrice } ${getTranslated("sar", context)}",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14, color: ColorResources.ACTIVE)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
