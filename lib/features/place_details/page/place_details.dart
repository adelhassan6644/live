import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/components/animated_widget.dart';
import 'package:live/components/custom_network_image.dart';
import 'package:live/features/place_details/provider/place_details_provider.dart';
import 'package:live/features/place_details/widgets/place_details_images_widget.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/maps_sheet.dart';
import '../repo/place_details_repo.dart';
import '../widgets/place_details_widget.dart';

class PlaceDetails extends StatefulWidget {
  final int id;

  const PlaceDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // Provider.of<PlaceDetailsProvider>(context, listen: false).model = null;
      // Provider.of<PlaceDetailsProvider>(context, listen: false)
      //     .geDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceDetailsProvider(repo: sl<PlaceDetailsRepo>())
        ..getDetails(widget.id)
        ..checkFollowPlace(widget.id),
      child:
          Consumer<PlaceDetailsProvider>(builder: (context, provider2, child) {
        return Scaffold(
          backgroundColor: ColorResources.BACKGROUND_COLOR,
          body: SafeArea(
            top: false,
            child: Consumer<PlaceDetailsProvider>(
                builder: (context, provider, child) {
              return provider.isLoading
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomNetworkImage.containerNewWorkImage(
                            image: "",
                            width: context.width,
                            height: context.height,
                            fit: BoxFit.fitWidth,
                            radius: 0),
                        const Column(
                          children: [
                            CustomAppBar(),
                            Expanded(child: SizedBox()),
                            PlaceDetailsWidgetShimmer(),
                          ],
                        ),
                      ],
                    )
                  : provider.model != null
                      ? SizedBox(
                          height: context.height,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: PlaceDetailsImagesWidget(
                                    images: provider.model!.images!),
                              ),
                              const Positioned(top: 0, child: CustomAppBar()),
                              DraggableScrollableSheet(
                                  initialChildSize: 0.30,
                                  minChildSize: 0.30,
                                  maxChildSize: .85,
                                  builder: (BuildContext context,
                                      ScrollController scrollController) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: provider.model!.images!
                                              .map((place) {
                                            int index = provider.model!.images!
                                                .indexOf(place);
                                            return AnimatedContainer(
                                              width:
                                                  index == provider.placesIndex
                                                      ? 25
                                                      : 8,
                                              height: 8,
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.w),
                                              decoration: BoxDecoration(
                                                  color: index ==
                                                          provider.placesIndex
                                                      ? ColorResources
                                                          .SECOUND_PRIMARY_COLOR
                                                      : ColorResources
                                                          .WHITE_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.w),
                                                  border: Border.all(
                                                      color: ColorResources
                                                          .SECOUND_PRIMARY_COLOR,
                                                      width: 1)),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Dimensions
                                                    .PADDING_SIZE_SMALL.h),
                                            decoration: const BoxDecoration(
                                                color:
                                                    ColorResources.WHITE_COLOR,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(35),
                                                    topRight:
                                                        Radius.circular(35))),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: Container(
                                                      height: 5.h,
                                                      width: 36.w,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                                  0xFF3C3C43)
                                                              .withOpacity(0.3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                      child: const SizedBox(),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Expanded(
                                                  child: ListAnimator(
                                                    controller:
                                                        scrollController,
                                                    data: [
                                                      PlaceDetailsWidget(
                                                        placeItem:
                                                            provider.model!,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        )
                      :  Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: EmptyState(
                              emptyHeight: 200,
                              imgHeight: 110,
                            ),
                        ),
                      );
            }),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              text: getTranslated("location", context),
              onTap: () async {
                final placeItem = provider2.model;
                MapsSheet.show(
                  context: context,
                  onMapTap: (map) {
                    Navigator.pop(context);
                    map.   showMarker(
                      coords: Coords(placeItem!.lat!, placeItem!.long!),
                      title: placeItem.name!,
                    );
                  },
                );

              },
            ),
          ),
        );
      }),
    );
  }
}
