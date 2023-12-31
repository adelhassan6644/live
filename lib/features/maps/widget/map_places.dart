import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/components/empty_widget.dart';
import 'package:live/main_widgets/place_card.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../provider/location_provider.dart';

class MapPlaces extends StatelessWidget {
  const MapPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      child: Consumer<LocationProvider>(builder: (_, provider, child) {
        return provider.isGetPlaces
            ? SizedBox(
          height: 232.h,
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
                    itemBuilder: (_, index) =>  CustomShimmerContainer(height:220.h ,width: 210.w,),
                    separatorBuilder: (_, index) => SizedBox(
                      width: 12.w,
                    ),
                    itemCount: 5),
              ),
            ],
          ),
        )
            : provider.placesModel != null &&
            provider.placesModel?.data != null &&
            provider.placesModel!.data!.isNotEmpty
            ? SizedBox(
          height: 232.h,
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
                    itemBuilder: (_, index) => PlaceCard(place: provider.placesModel!.data![index]),
                    separatorBuilder: (_, index) => SizedBox(
                      width: 12.w,
                    ),
                    itemCount: provider.placesModel!.data!.length),
              ),
            ],
          ),
        )
            : Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w*2,vertical:
          Dimensions.PADDING_SIZE_DEFAULT.h*2),
            decoration: BoxDecoration(
              color: ColorResources.WHITE_COLOR,
              borderRadius: BorderRadius.circular(16)
            ),
            child: const EmptyState(emptyHeight: 220,txt: "لا يوجد اماكن قريبة منك",));
      }),
    );
  }
}

