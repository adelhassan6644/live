import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/core/utils/color_resources.dart';
import '../../../../../app/core/utils/dimensions.dart';
import '../../../../../app/core/utils/svg_images.dart';
import '../../../../../app/core/utils/text_styles.dart';
import '../../../../../components/animated_widget.dart';
import '../../../../../components/custom_app_bar.dart';
import '../../../../../components/custom_images.dart';
import '../../../../../components/custom_network_image.dart';
import '../../../../app/localization/localization/language_constant.dart';
import '../../../../main_widgets/offer_card.dart';
import '../../../components/grid_list_animator.dart';
import '../../../main_widgets/place_card.dart';

class LatestPlacesScreen extends StatelessWidget {
  const LatestPlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          ),
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: Text( getTranslated("new_places", context),
                        style: AppTextStyles.semiBold.copyWith(
                            fontSize: 24, color: ColorResources.HEADER)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: GridListAnimatorWidget(
                      items: List.generate(
                        provider.placesModel?.data!.length ?? 0,
                            (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration:
                            const Duration(milliseconds: 375),
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: PlaceCard(
                                  place:  provider.placesModel!.data![index]
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                  ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
