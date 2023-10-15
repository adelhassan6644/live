import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_network_image.dart';
import '../main_models/offers_model.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({required this.offer, super.key});
  final OfferItem offer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => CustomNavigator.push(Routes., arguments: offer.id),
      child: Container(
        width: 210.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: ColorResources.GREY_BORDER,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNetworkImage.containerNewWorkImage(
              image: offer.image ?? "",
              height: 120.h,
              width: context.width,
              fit: BoxFit.cover,
              edges: true,
              radius: 12.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(children: [
                Text("${offer.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 16, color: ColorResources.TITLE)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text("${offer.description}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.light.copyWith(
                          fontSize: 14, color: ColorResources.DETAILS_COLOR)),
                ),
              ],),
            )

          ],
        ),
      ),
    );
  }
}
