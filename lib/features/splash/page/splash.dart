import 'package:live/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:live/features/splash/provider/splash_provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../contact_with_us/provider/contact_provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);



    Provider.of<SplashProvider>(CustomNavigator.navigatorState.currentContext!,
            listen: false)
        .startTheApp();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.SPLASH_BACKGROUND_COLOR,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                height: context.height,
                width: context.width,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: ColorResources.SPLASH_BACKGROUND_COLOR),
                child: const SizedBox()),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Image.asset(
                Images.logo,
                width: context.width,
                height: 250,
              ),
              Text(
                " حمدانيتنا سعادتنا",
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 24, color: ColorResources.WHITE_COLOR),
              ),
            ])
                .animate()
                .slideX(duration: 600.ms)
                .then(delay: 400.ms)
                .shimmer(duration: 600.ms),
          ],
        ));
  }
}
