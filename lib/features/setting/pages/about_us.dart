import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/data/api/end_points.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_images.dart';
import '../../../main_widgets/software_copyRight.dart';
import '../widgets/contact_us.dart';
import '../widgets/developer_description.dart';
import '../widgets/developer_image.dart';
import '../widgets/developer_information.dart';
import '../widgets/developer_social_media.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
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
                  // ContactUS(),
                  DeveloperSocialMedia(),

                  SizedBox(
                    height: 24,
                  ),
                  //
                ],
              )),
              SoftwareCloudCopyRight()
            ],
          ),
        ));
  }
}
