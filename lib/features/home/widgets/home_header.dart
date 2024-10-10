import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/svg_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../contact_with_us/provider/contact_provider.dart';
import '../../setting/provider/setting_provider.dart';
import '../../setting/widgets/developer_social_media.dart';
import 'home_search.dart';
import 'home_social_media.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(builder: (_, provider, child){
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(children: [

                    SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT.h,
                    ),
                    Text(
                      provider.contactModel?.homeTitle??  " حياك الله فى أحياء الحمدانية",
                      style: AppTextStyles.bold.copyWith(
                          fontSize: 23, color: ColorResources.SECOUND_PRIMARY_COLOR),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      provider.contactModel?.homeSlugen??  " خلنا نعرفك على اماكن واخبار وعروض الحى",
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 16, color: ColorResources.TITLE),
                    ),

                  ],),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      CustomNavigator.push(
                        Routes.NOTIFICATIONS,
                      );
                    },
                    child: Container(
                      height: 27.5 * 2,
                      width: 27.5 * 2,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 27.5,
                        backgroundColor: ColorResources.SECOUND_PRIMARY_COLOR,
                        child: SvgPicture.asset(SvgImages.notifications,color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),

              HomeSocialMedia(fromDashBoard: true,),
              HomeSearch(),
              SizedBox(
                height: 20.h,
              ),

            ],
          ),
        );
      }
    );
  }
}
