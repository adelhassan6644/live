import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/components/custom_app_bar.dart';
import 'package:live/components/custom_button.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:live/features/offer_details/repo/offer_details_repo.dart';
import 'package:provider/provider.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/animated_widget.dart';
import '../../../components/custom_network_image.dart';
import '../../../data/config/di.dart';
import '../../offer_details/widget/offer_details_body.dart';
import '../../place_details/widgets/imagegalleryOverlay.dart';
import '../provider/news_details_provider.dart';
import '../repo/news_details_repo.dart';
import '../widget/news_details_body.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    StreamController<Widget> overlayController =
        StreamController<Widget>.broadcast();
    ImageGalleryController galleryController =
        ImageGalleryController(initialPage: 0);
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (_) =>
              NEwsDetailsProvider(repo: sl<NewsDetailsRepo>())..getDetails(id),
          child: Consumer<NEwsDetailsProvider>(builder: (_, provider, child) {
            return Column(
              children: [
                CustomAppBar(
                  title: getTranslated("news_details", context),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    ),
                    child: provider.isLoading
                        ? const OfferDetailsShimmer()
                        : Column(
                            children: [
                              AnimatedCrossFade(
                                crossFadeState: provider.goingDown
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 500),
                                firstChild: SizedBox(width: context.width),
                                secondChild: InkWell(
                                  onTap: () async {
                                    List<Widget> imagesWithUrl = [];
                                    if (provider.model?.images == null) {
                                      imagesWithUrl.add(CustomNetworkImage
                                          .containerNewWorkImage(
                                              image: provider.model!.image!,
                                              width: context.width,
                                              fit: BoxFit.contain,
                                              // height: context.height/10,
                                              radius: 0));
                                    }
                                    provider.model?.images?.forEach((element) {
                                      imagesWithUrl.add(CustomNetworkImage
                                          .containerNewWorkImage(
                                              image: element,
                                              width: context.width,
                                              fit: BoxFit.contain,
                                              // height: context.height/10,
                                              radius: 0));
                                    });
                                    await SwipeImageGallery(
                                      context: context,
                                      controller: galleryController,
                                      children: imagesWithUrl,
                                      hideStatusBar: false,
                                      onSwipe: (index) {},
                                      initialOverlay: GalleryOverlay(
                                        title:
                                            '1/${provider.model?.images?.length}',
                                      ),
                                      overlayController: overlayController,
                                      backgroundOpacity: 0.5,
                                    ).show();
                                  },
                                  child: CarouselSlider.builder(
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay:
                                          provider.model!.images!.length > 1
                                              ? true
                                              : false,
                                      height: 220.h,
                                      enlargeCenterPage: false,
                                      disableCenter: true,
                                      pageSnapping: true,
                                      onPageChanged: (index, reason) {
                                        // provider.setPlacesIndex(index);
                                        // galleryController =
                                        //     ImageGalleryController(initialPage: index);
                                      },
                                    ),
                                    disableGesture: true,
                                    itemCount: provider.model?.images?.length??0,
                                    itemBuilder: (context, index, _) {
                                      return CustomNetworkImage
                                          .containerNewWorkImage(
                                        image: provider.model!.images?[index] ??
                                            provider.model!.image ??
                                            '',
                                        height: 220.h,
                                        width: context.width,
                                        fit: BoxFit.cover,
                                        radius: 20,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const NewsDetailsBody(),
                            ],
                          ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class OfferDetailsShimmer extends StatelessWidget {
  const OfferDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      data: [
        CustomShimmerContainer(
          height: 220.h,
          radius: 20,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          child: Row(
            children: [
              const CustomShimmerCircleImage(
                diameter: 56,
              ),
              SizedBox(
                width: 12.w,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerText(
                      width: 100,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CustomShimmerText(
                      width: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ///Store Offer
        const CustomShimmerText(
          width: 100,
        ),

        SizedBox(height: 8.h),

        ///Store Offer
        ...List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: CustomShimmerText(
              width: context.width,
            ),
          ),
        ),

        ///Offer Prices
        Padding(
          padding: EdgeInsets.only(
              bottom: 8.h, top: Dimensions.PADDING_SIZE_DEFAULT.h),
          child: const Row(
            children: [
              CustomShimmerText(
                width: 100,
              ),
              SizedBox(
                width: 4,
              ),
              CustomShimmerText(
                width: 100,
              ),
              Spacer(),
              CustomShimmerContainer(
                height: 30,
                width: 60,
                radius: 4,
              )
            ],
          ),
        ),

        ///Expired Date of Offer
        const CustomShimmerText(
          width: 200,
        ),
      ],
    );
  }
}
