import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/dimensions.dart';
import '../../../../app/core/utils/svg_images.dart';
import '../../../../app/core/utils/text_styles.dart';
import '../../../../components/animated_widget.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/custom_images.dart';
import '../../../../components/custom_network_image.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/offer_card.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

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
                    child: Text( getTranslated("offers", context),
                        style: AppTextStyles.semiBold.copyWith(
                            fontSize: 24, color: ColorResources.HEADER)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: ListAnimator(
                      data: List.generate(
                          provider.offersModel?.data!.length ?? 0,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OfferCard(
                                offer:
                                provider.offersModel!.data![index]),
                          ),

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
