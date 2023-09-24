import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:live/navigation/routes.dart';
import 'package:provider/provider.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../components/custom_network_image.dart';
import '../../../data/api/end_points.dart';
import '../provider/place_details_provider.dart';
import 'imagegalleryOverlay.dart';

class PlaceDetailsImagesWidget extends StatelessWidget {
  final List<String> images;
  const PlaceDetailsImagesWidget({Key? key, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StreamController<Widget> overlayController =
        StreamController<Widget>.broadcast();
    ImageGalleryController galleryController =
        ImageGalleryController(initialPage: 0);
    return images.isEmpty
        ? CustomNetworkImage.containerNewWorkImage(
            image: "",
            width: context.width,
            height: context.height,
            fit: BoxFit.fitWidth,
            radius: 0)
        : Consumer<PlaceDetailsProvider>(builder: (context, provider, child) {
            return InkWell(
              onTap: () async {
                List<Widget> imagesWithUrl = [];

                images.forEach((element) {
                  imagesWithUrl.add(CustomNetworkImage.containerNewWorkImage(
                      image: element,
                      width: context.width,
                      fit: BoxFit.fitHeight,
                      // height: context.height/10,
                      radius: 0));
                });
                await SwipeImageGallery(
                  context: context,
                  controller: galleryController,
                  children: imagesWithUrl,
                  hideStatusBar: false,
                  onSwipe: (index) {

                  },
                  initialOverlay: GalleryOverlay(
                    title: '1/${imagesWithUrl.length}',
                  ),
                  overlayController: overlayController,
                  backgroundOpacity: 0.5,
                ).show();
              },
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: images.length > 1 ? true : false,
                  height: context.height * .8,
                  enlargeCenterPage: false,
                  disableCenter: true,
                  pageSnapping: true,
                  onPageChanged: (index, reason) {
                    provider.setPlacesIndex(index);
                    galleryController =
                        ImageGalleryController(initialPage: index);
                  },
                ),
                disableGesture: true,
                itemCount: images.length,
                itemBuilder: (context, index, _) {
                  return CustomNetworkImage.containerNewWorkImage(
                      image: images[index],
                      width: context.width,
                      fit: BoxFit.fitHeight,
                      // height: context.height/10,
                      radius: 0);
                },
              ),
            );
          });
  }
}
