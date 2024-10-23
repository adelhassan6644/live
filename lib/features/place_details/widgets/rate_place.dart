import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:live/app/core/utils/app_snack_bar.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/components/custom_text_form_field.dart';
import 'package:photo_manager/src/types/entity.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/file_picker_helper.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../main_widgets/video_player_widget.dart';
import '../provider/place_details_provider.dart';

class RatePlace extends StatelessWidget {
  const RatePlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceDetailsProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        padding: EdgeInsets.symmetric(
            vertical: 14.h, horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        decoration: BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 2),
                  color: Colors.black.withOpacity(0.03),
                  spreadRadius: 5,
                  blurRadius: 10)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "شاركنا تقييمك، رأيك مهم",
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            RatingBar.builder(
              initialRating: 2,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 3,
              itemSize: 50,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );

                  case 1:
                    return const Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 2:
                    return const Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                }
                return const Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              },
              onRatingUpdate: (rating) {
                provider.setRate(rating);
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomTextFormField(
              minLine: 4,
              maxLine: 6,
              controller: provider.commentTEC,
              hint: "أخبرنا بالمزيد. . . ",
              sufWidget: IconButton(
                onPressed: () async {
                  await FilePickerHelper.pickMedia(
                      context: context,
                      onSelectedMulti: (v) => provider.setRateMedia(v));
                },
                icon: Icon(
                  Icons.attach_file,
                  color: ColorResources.SECOUND_PRIMARY_COLOR,
                ),
              ),
            ),
            if(provider.rateMedia!=null)
            SizedBox(
              height: 130.h,
              child: ListView.builder(
                itemCount: provider.rateMedia?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: !provider.rateMedia![index]!.path.contains(".mp4")
                              ? Image.file(
                                  provider.rateMedia![index]!,
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                )
                              : VideoPlayerWidget(
                                  filePath: provider.rateMedia![index]!.path,
                                ),
                        ),
                      ),
                      IconButton(onPressed: (){
                        provider.removeRateMedia(index);
                      }, icon: Icon(Icons.delete,color: Colors.red,))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomButton(
              text: getTranslated("rate", context),
              width: 110,
              onTap: () {
                if (!provider.isLogin) {
                  showToast("برجاء تسجيل الدخول اولاً");
                  return;
                }
                if (provider.commentTEC.text.trim() == '') {
                  showToast("برجاء كتابة تقيم");
                  return;
                }
                provider.ratePlace();
              },
              height: 45,
              withBorderColor: false,
              withShadow: true,
              iconSize: 15,
              textColor: ColorResources.WHITE_COLOR,
              svgIcon: SvgImages.arrowRightIcon,
              iconColor: ColorResources.WHITE_COLOR,
              // backgroundColor: ColorResources.SECOUND_PRIMARY_COLOR,
              textSize: 16,
            ),
          ],
        ),
      );
    });
  }
}
