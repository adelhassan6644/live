import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/components/custom_button.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:live/navigation/routes.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: InkWell(
            onTap: () {
              CustomNavigator.push(
                Routes.SEARCH,
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      height: 27.5 * 2,
                      width: 27.5 * 2,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: ColorResources.SECOUND_PRIMARY_COLOR,
                              width: 1),
                          borderRadius: BorderRadius.circular(27.5)),
                      child: const Row(
                        children: [
                          Text(
                            "        ابحث هنا ",
                            style: TextStyle(
                                color: ColorResources.DETAILS_COLOR,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 27.5 * 2,
                  width: 27.5 * 2,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 27.5,
                    backgroundColor: ColorResources.SECOUND_PRIMARY_COLOR,
                    child: SvgPicture.asset(Images.search),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
