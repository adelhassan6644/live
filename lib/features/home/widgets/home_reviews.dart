import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:live/main_widgets/offer_card.dart';
import 'package:live/main_widgets/reviews_card.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class HomeReviews extends StatelessWidget {
  const HomeReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          ),
          child: Row(
            children: [
              Text(
                "اخر التعليقات",
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 24, color: ColorResources.HEADER),
              ),
              SizedBox(width: 10,),
              Image.asset(
                Images.comments,
                // color:ColorResources.HEADER ,
                height: 30,
                width: 30,
              ),
             /* Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () =>
                      CustomNavigator.push(Routes.OffersScreen),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        "المزيد",
                        style: AppTextStyles.medium
                            .copyWith(
                            fontSize: 16,
                            color: ColorResources
                                .DETAILS_COLOR),
                      ),
                      customImageIconSVG(
                          imageName:
                          SvgImages.arrowRightIcon,
                          color: ColorResources
                              .DETAILS_COLOR),
                    ],
                  ),
                ),
              )*/
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Consumer<HomeProvider>(builder: (_, provider, child) {
            return provider.isGetReviews
                ? SizedBox(
                    height: 245.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Dimensions.PADDING_SIZE_DEFAULT.w,
                        ),
                        Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (_, index) => CustomShimmerContainer(
                                    height: 200.h,
                                    width: 210.w,
                                  ),
                              separatorBuilder: (_, index) => SizedBox(
                                    width: 12.w,
                                  ),
                              itemCount: 5),
                        ),
                      ],
                    ),
                  )
                : provider.reviewsModel != null &&
                        provider.reviewsModel?.data != null &&
                        provider.reviewsModel!.data!.isNotEmpty
                    ? SizedBox(
                        height: 250,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_DEFAULT.w,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,

                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (_, index) => ReviewsCard(
                                      review:
                                          provider.reviewsModel!.data![index]),
                                  separatorBuilder: (_, index) => SizedBox(
                                        width: 12.w,
                                      ),
                                  itemCount:
                                      provider.reviewsModel!.data!.length),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox();
          }),
        ),
      ],
    );
  }
}
