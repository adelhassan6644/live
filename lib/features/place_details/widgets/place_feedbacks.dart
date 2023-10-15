import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../provider/place_details_provider.dart';

class PlaceFeedBacks extends StatelessWidget {
  const PlaceFeedBacks({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceDetailsProvider>(builder: (context, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_SMALL.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: (provider.feedBacks != null &&
                  provider.feedBacks?.data != null &&
                  provider.feedBacks!.data!.isNotEmpty),
              child: Text(
                "التقيمات السابقة",
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 24, color: ColorResources.HEADER),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            provider.isGetOffers
                ? const _OfferShimmer()
                : provider.feedBacks != null &&
                        provider.feedBacks?.data != null &&
                        provider.feedBacks!.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: provider.feedBacks!.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                                vertical: Dimensions.PADDING_SIZE_SMALL.h),
                            decoration: BoxDecoration(
                                color: ColorResources.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(2, 2),
                                      color: Colors.black.withOpacity(0.03),
                                      spreadRadius: 5,
                                      blurRadius: 10)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomNetworkImage.circleNewWorkImage(
                                  radius: 30,
                                  backGroundColor:
                                      ColorResources.SECOUND_PRIMARY_COLOR,
                                  image: provider
                                      .feedBacks!.data![index].clientImage,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.feedBacks!.data![index]
                                                .clientName ??
                                            "",
                                        style: AppTextStyles.semiBold
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        provider.feedBacks!.data![index]
                                                .comment ??
                                            "",
                                        style: AppTextStyles.regular
                                            .copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  provider.feedBacks!.data![index].rating
                                      .toString(),
                                  style: AppTextStyles.semiBold.copyWith(),
                                ),
                                Visibility(
                                  visible: (provider
                                          .feedBacks!.data![index].rating ==
                                      1),
                                  child: const Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                ),
                                Visibility(
                                  visible: (provider
                                          .feedBacks!.data![index].rating ==
                                      2),
                                  child: const Icon(
                                    Icons.sentiment_satisfied,
                                    color: Colors.lightGreen,
                                    size: 35,
                                  ),
                                ),
                                Visibility(
                                  visible: (provider
                                          .feedBacks!.data![index].rating ==
                                      3),
                                  child: const Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Colors.green,
                                    size: 35,
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    : const SizedBox(),
          ],
        ),
      );
    });
  }
}

class _OfferShimmer extends StatelessWidget {
  const _OfferShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Container(
            width: context.width,
            height: 205.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorResources.WHITE_COLOR,
            )),
      ),
    );
  }
}
