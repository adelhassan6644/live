import 'package:flutter/material.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/features/about_us/widgets/developer_description.dart';
import 'package:live/features/about_us/widgets/developer_image.dart';
import 'package:live/features/about_us/widgets/developer_information.dart';
import 'package:live/features/about_us/widgets/developer_social_media.dart';
import '../../components/animated_widget.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: ColorResources.BACKGROUND_COLOR,
        body: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              Expanded(
                  child: ListAnimator(
                data: [
                  DeveloperImage(),
                  DeveloperDescription(),
                  DeveloperInformation(),
                  DeveloperSocialMedia(),
                  SizedBox(
                    height: 24,
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
