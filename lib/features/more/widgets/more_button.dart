import 'package:live/app/core/utils/color_resources.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../../../main_page/provider/main_page_provider.dart';

class MoreButton extends StatelessWidget {
  const MoreButton(
      {required this.title, required this.icon, this.onTap, Key? key})
      : super(key: key);
  final String title, icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
          sl<MainPageProvider>().updateIsOpen(false);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customImageIconSVG(
                imageName: icon,
                height: 20,
                width: 20,
                color: ColorResources.WHITE_COLOR),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(title,
                        maxLines: 1,
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            color: ColorResources.WHITE_COLOR)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
