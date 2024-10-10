import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/data/api/end_points.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_images.dart';
import '../../../main_widgets/software_copyRight.dart';
import '../provider/setting_provider.dart';
import '../widgets/contact_us.dart';
import '../widgets/developer_description.dart';
import '../widgets/developer_image.dart';
import '../widgets/developer_information.dart';
import '../widgets/developer_social_media.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final sochialMediaList=[
      CustomSochial(image: SvgImages.x, name: "x", link: Provider.of<SettingProvider>(context,listen: false).model?.data?.twitter??"", color: 0xff4B4B4B),
      CustomSochial(image: SvgImages.youtube, name: "Youtube", link: Provider.of<SettingProvider>(context,listen: false).model?.data?.youtube??"", color: 0xffFF2323),
      CustomSochial(image: SvgImages.snap, name: "Snapchat", link: Provider.of<SettingProvider>(context,listen: false).model?.data?.snapchat??"", color: 0xffF3F815),
      CustomSochial(image: SvgImages.faceBook2, name: "FaceBook", link: Provider.of<SettingProvider>(context,listen: false).model?.data?.facebook??"", color: 0xff1539F8),




    ];
    return Scaffold(
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
                /*  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: sochialMediaList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(2, 2),
                                      spreadRadius: 3,
                                      blurRadius: 5)
                                ],
                                color: ColorResources.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    customContainerSvgIcon(
                                        imageName: sochialMediaList[index].image,
                                        height: 80.0.w,
                                        width: 80.0.w,
                                        color: Colors.transparent,
                                        withShadow: false,
                                        onTap: () async {
                                          // launchUrl(
                                          //     Uri.parse(provider.model?.data?.facebook ?? ""),
                                          //     mode: LaunchMode.externalApplication);
                                        }),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        sochialMediaList[index].name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: Color( sochialMediaList[index].color)),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "+ 20k متابع",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff4B4B4B)),
                                )
                              ],
                            ));
                      },
                    ),
                  ),*/
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


class CustomSochial{
  final String image;
  final String name;
  final String link;
  final int color;

  CustomSochial(  {required this.image, required this.name, required this.color,required this.link,});

}