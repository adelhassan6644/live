import 'package:flutter/material.dart';
import 'package:live/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/image_pop_up_viewer.dart';
import '../../../helpers/image_picker_helper.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {required this.withEdit, this.radius = 57.5, Key? key})
      : super(key: key);
  final bool withEdit;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ProfileProvider>(builder: (_, provider, child) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                if (withEdit) {
                  ImagePickerHelper.showOptionSheet(
                      onGet: provider.onSelectImage);
                } else {
                  if (provider.profileImage != null || provider.image != null) {
                    showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.75),
                        builder: (context) {
                          return ImagePopUpViewer(
                            image: provider.profileImage ?? provider.image,
                            isFromInternet:
                                provider.profileImage != null ? false : true,
                            title: "",
                          );
                        });
                  }
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  provider.profileImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: radius * 2,
                            width: radius * 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: ColorResources.PRIMARY_COLOR,
                                    width: 1)),
                            child: Image.file(
                              provider.profileImage!,
                              height: radius * 2,
                              width: radius * 2,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                      child: Container(
                                          height: radius * 2,
                                          width: radius * 2,
                                          color: Colors.grey,
                                          child: const Center(
                                              child: Icon(Icons.replay,
                                                  color: Colors.green)))),
                            ),
                          ),
                        )
                      : CustomNetworkImage.circleNewWorkImage(
                          color: ColorResources.PRIMARY_COLOR,
                          image: provider.image,
                          radius: radius),
                  if (withEdit)
                    Container(
                        height: radius * 2,
                        width: radius * 2,
                        padding: const EdgeInsets.all(47),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorResources.PRIMARY_COLOR,
                            ),
                            color: ColorResources.HINT_COLOR.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(100)),
                        child: customImageIconSVG(
                            imageName: SvgImages.editor,
                            height: 24,
                            width: 24,
                            color: ColorResources.WHITE_COLOR)),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
