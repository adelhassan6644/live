import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';

class DeveloperImage extends StatelessWidget {
  const DeveloperImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 160 + context.toPadding,
            width: context.width,
            margin: const EdgeInsets.only(bottom: 68),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.profileBGImage),
                    fit: BoxFit.fitHeight)),
            child: const SizedBox(),
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              clipBehavior: Clip.antiAlias,
              child: customImageIcon(
                  imageName: Images.developerImage,
                  height: 163,
                  width: 163))
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Center(
        child: Text(
          "Software Cloud 2",
          style: AppTextStyles.medium.copyWith(
              color: const Color(0xFFF8A14E), fontSize: 16),
        ),
      ),
      SizedBox(
        height: 30.h,
      ),
    ],);
  }
}
