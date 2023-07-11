import 'package:flutter/cupertino.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../profile/widgets/profile_image_widget.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_,provider,child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Row(
              children: [
                ProfileImageWidget(
                  withEdit: false,
                  radius: 28.5,
                ),
                Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              provider.nameTEC.text.trim(),
              style: AppTextStyles.bold.copyWith(color: ColorResources.WHITE_COLOR, fontSize: 16,height: 1),
            ),
            Text(
              provider.emailTEC.text.trim(),
              style: AppTextStyles.regular
                  .copyWith(color: ColorResources.WHITE_COLOR, fontSize: 12),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        );
      }
    );
  }
}
