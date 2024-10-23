import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/components/custom_images.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_network_image.dart';
import '../features/home/models/reviews_model.dart';
import '../main_models/offers_model.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class ReviewsCard extends StatelessWidget {
  const ReviewsCard({required this.review, super.key});
  final ReviewItem review;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          CustomNavigator.push(Routes.PLACE_DETAILS, arguments: review.placeId),
      child: Container(
        width: context.width * .80,

        decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 2),
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: 5,
                  blurRadius: 10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Image
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomNetworkImage.circleNewWorkImage(
                    image: review.clientImage ?? "",
                    placholder: Images.userAvtar,
                    radius: 38)
              ],
            ),

            ///Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Store Offer
                  Text(review.clientName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 18, color: ColorResources.TITLE)),

                  Text("${review.comment ?? "Place name"}  ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regular.copyWith(
                          fontSize: 14, color: ColorResources.DETAILS_COLOR)),
                  SizedBox(
                    height: 10,
                  ),

                  ///Store Name && Rate
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        width: context.width * .70,
                        child: Center(
                          child: ListView.builder(
                            itemCount: review.rating,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (c, i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: customImageIconSVG(
                                  imageName: SvgImages.fillStar,
                                  height: 18,
                                  width: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: ColorResources.BORDER_COLOR_Light,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(review.placeName ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regular.copyWith(
                              fontSize: 14,
                              color: ColorResources.SECOUND_PRIMARY_COLOR)),
                    ),
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
