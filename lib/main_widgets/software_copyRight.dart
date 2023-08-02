import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/core/utils/text_styles.dart';
import '../data/api/end_points.dart';



class SoftwareCloudCopyRight extends StatelessWidget {
  const SoftwareCloudCopyRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    InkWell(
      onTap: (){

        launchUrl(
            Uri.parse(     EndPoints.softwarecloud2),
            mode: LaunchMode.externalApplication);
      },
      child: Text(
        "جميع الحقوق محفوظةل©Software Cloud2  ",
        maxLines: 2,
        textAlign: TextAlign.center,
        style: AppTextStyles.medium.copyWith(
            color: const Color(0xFFF8A14E),
            fontSize: 16,

            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
