import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/features/favourite/widgets/favourite_button.dart';
import 'package:live/main_models/places_model.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.place,
  }) : super(key: key);
  final PlaceItem place;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () =>
              CustomNavigator.push(Routes.PLACE_DETAILS, arguments: place.id),
          child: Container(
            width: 210.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: ColorResources.GREY_BORDER,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${place.category}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.light.copyWith(
                        fontSize: 14, color: ColorResources.DETAILS_COLOR)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text("${place.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: place.nameColor?.toColor ??
                              ColorResources.SECOUND_PRIMARY_COLOR)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customImageIconSVG(
                        imageName: SvgImages.location,
                        height: 20,
                        width: 20,
                        color: ColorResources.TITLE),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: Text(
                        place.address ?? "",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: ColorResources.TITLE),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                SizedBox(
                  height: 130.h,
                  child: Stack(
                    children: [
                      CustomNetworkImage.containerNewWorkImage(
                        image: place.image ?? "",
                        height: 140.h,
                        width: context.width,
                        fit: BoxFit.cover,
                        edges: true,
                        radius: 8.w,
                      ),
                      if(place.mostViewed==1)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffF1A129),
                              borderRadius: BorderRadius.circular(10)),
                  
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("الأكثر مشاهدة",style: TextStyle(
                                fontSize: 18,
                                color: Colors.white),),
                          ),),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(top: -10, left: -10, child: FavouriteButton(id: place.id))
      ],
    );
  }
}
