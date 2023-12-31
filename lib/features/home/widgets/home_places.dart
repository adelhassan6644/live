import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:live/main_widgets/place_card.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/shimmer/custom_shimmer.dart';

class HomePlaces extends StatelessWidget {
  const HomePlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            ),
            child: Row(
              children: [
                Text(
                  getTranslated("new_places", context),
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
          Consumer<HomeProvider>(builder: (_, provider, child) {
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
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}

