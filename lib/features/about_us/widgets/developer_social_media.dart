import 'package:flutter/material.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/components/custom_images.dart';

class DeveloperSocialMedia extends StatelessWidget {
  const DeveloperSocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customCircleSvgIcon(imageName: SvgImages.faceBook)
      ],);
  }
}
