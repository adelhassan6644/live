import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/images.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../provider/place_details_provider.dart';

class PlaceOffers extends StatelessWidget {
  const PlaceOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceDetailsProvider>(builder: (context, provider, child) {

      return Column(
        children: [
          if(    provider.offersModel != null &&
              provider.offersModel?.data != null &&
              provider.offersModel!.data!.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            ),
            child: Row(
              children: [
                Text(
                  "العروض ",
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
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_SMALL.h),
            child: provider.isGetOffers
                ? const _OfferShimmer()
                :
            provider.offersModel != null &&
                        provider.offersModel?.data != null &&
                        provider.offersModel!.data!.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              height: 205.h,
                              onPageChanged: (index, reason) {
                                provider.setOffersIndex(index);
                              },
                            ),
                            disableGesture: true,
                            itemCount: provider.offersModel?.data?.length ?? 0,
                            itemBuilder: (context, index, _) {
                              return InkWell(
                                onTap: (){
                                  CustomNavigator.push(Routes.PLACE_DETAILS,
                                      arguments: provider.offersModel
                                          ?.data?[index].id ??
                                          0);
                                },
                                child: CustomNetworkImage.containerNewWorkImage(
                                    image: provider
                                            .offersModel?.data?[index].image ??
                                        "",
                                    width: context.width,
                                    height: 205.h,
                                    fit: BoxFit.cover,
                                    radius: 20),
                              );
                            },
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: provider.offersModel!.data!.map((offer) {
                              int index =
                                  provider.offersModel!.data!.indexOf(offer);
                              return AnimatedContainer(
                                width: index == provider.offersIndex ? 25 : 8,
                                height: 8,
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    color: index == provider.offersIndex
                                        ? ColorResources.SECOUND_PRIMARY_COLOR
                                        : ColorResources.WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(100.w),
                                    border: Border.all(
                                        color: ColorResources
                                            .SECOUND_PRIMARY_COLOR,
                                        width: 1)),
                              );
                            }).toList(),
                          ),
                        ],
                      )
                    : const SizedBox()
          ),
        ],
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
