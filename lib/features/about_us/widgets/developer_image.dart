import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';

class DeveloperImage extends StatelessWidget {
  const DeveloperImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 160 + context.toPadding,
              width: context.width,
              margin: const EdgeInsets.only(bottom: 70),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.profileBGImage),
                      fit: BoxFit.fitHeight)),
              child: const SizedBox(),
            ),
            Column(
              children: [
                const CustomAppBar(),
                ClipRect(
                    clipBehavior: Clip.antiAlias,
                    child: customImageIcon(
                        imageName: Images.developerImage,
                        height: 160,
                        width: 160)),
              ],
            ),
          ],
        ),
        Center(
          child: Text(
            "Software Cloud 2",
            style: AppTextStyles.medium
                .copyWith(color: const Color(0xFFF8A14E), fontSize: 16),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}
