import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/components/custom_button.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_SMALL.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            provider.isGetPlaces
                ? const _PlacesShimmer()
                : provider.placesModel != null &&
                        provider.placesModel?.data != null &&
                        provider.placesModel!.data!.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: false,
                              height: 245.h,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: false,
                              disableCenter: true,
                              pageSnapping: true,
                              onPageChanged: (index, reason) {
                                provider.setPlacesIndex(index);
                              },
                            ),
                            disableGesture: true,
                            itemCount: provider.placesModel?.data?.length ?? 0,
                            itemBuilder: (context, index, _) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CustomNetworkImage.containerNewWorkImage(
                                      image: provider.placesModel?.data?[index]
                                              .image ??
                                          "",
                                      width: context.width,
                                      height: 245.h,
                                      fit: BoxFit.cover,
                                      radius: 20),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 12.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          provider.placesModel?.data?[index]
                                                  .name ??
                                              "",
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 18,
                                              color: ColorResources.TITLE),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            customImageIconSVG(
                                              imageName: SvgImages.location,
                                              height: 20,
                                              width: 20,
                                              color: const Color(0xFFEBEBEB),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Expanded(
                                              child: Text(
                                                provider
                                                        .placesModel
                                                        ?.data?[index]
                                                        .address ??
                                                    "",
                                                style: AppTextStyles.medium
                                                    .copyWith(
                                                        fontSize: 18,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: ColorResources
                                                            .TITLE),
                                                maxLines: 2,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Visibility(
                                              visible:
                                                  index == provider.placesIndex,
                                              child: CustomButton(
                                                width: 110.w,
                                                height: 35.h,
                                                text: "المزيد",
                                                svgIcon:
                                                    SvgImages.arrowRightIcon,
                                                onTap: () {
                                                  provider.placesController
                                                      .nextPage();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            carouselController: provider.placesController,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: provider.placesModel!.data!.map((place) {
                              int index =
                                  provider.placesModel!.data!.indexOf(place);
                              return AnimatedContainer(
                                width: index == provider.placesIndex ? 25 : 8,
                                height: 8,
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    color: index == provider.placesIndex
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
                    : const EmptyState(
                        emptyHeight: 200,
                        imgHeight: 110,
                      ),
          ],
        ),
      );
    });
  }
}

class _PlacesShimmer extends StatelessWidget {
  const _PlacesShimmer({Key? key}) : super(key: key);

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
            height: 245.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorResources.WHITE_COLOR,
            )),
      ),
    );
  }
}
