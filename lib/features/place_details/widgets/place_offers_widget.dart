import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../main_widgets/offer_card.dart';
import '../provider/place_details_provider.dart';

class PlaceOffersWidget extends StatelessWidget {
  const PlaceOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceDetailsProvider>(builder: (_, provider, child) {
      return Visibility(
        visible: provider.isGetOffers ||
            (provider.offersModel != null &&
                provider.offersModel?.data != null &&
                provider.offersModel!.data!.isNotEmpty),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
                child: Row(
                  children: [
                    Text(
                      getTranslated("offers", context),
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 24, color: ColorResources.HEADER),
                    ),
                    Image.asset(
                      Images.megaPhone,
                      height: 26,
                      width: 26,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: provider.isGetOffers
                    ? SizedBox(
                        height: 255.h,
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
                                  itemBuilder: (_, index) =>
                                      CustomShimmerContainer(
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
                    : provider.offersModel != null &&
                            provider.offersModel?.data != null &&
                            provider.offersModel!.data!.isNotEmpty
                        ? SizedBox(
                            height: 255.h,
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
                                      itemBuilder: (_, index) => OfferCard(
                                          offer: provider
                                              .offersModel!.data![index]),
                                      separatorBuilder: (_, index) => SizedBox(
                                            width: 12.w,
                                          ),
                                      itemCount:
                                          provider.offersModel!.data!.length),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
