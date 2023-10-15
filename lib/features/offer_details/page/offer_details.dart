import 'package:flutter/material.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/components/custom_app_bar.dart';
import 'package:live/components/custom_button.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:live/features/offer_details/repo/offer_details_repo.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/animated_widget.dart';
import '../../../components/custom_network_image.dart';
import '../../../data/config/di.dart';
import '../provider/offer_details_provider.dart';
import '../widget/offer_details_body.dart';

class OfferDetails extends StatelessWidget {
  const OfferDetails({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) =>
            OfferDetailsProvider(repo: sl<OfferDetailsRepo>())..getDetails(id),
        child: Consumer<OfferDetailsProvider>(builder: (_, provider, child) {
          return Column(
            children: [
              const CustomAppBar(),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  ),
                  child: provider.isLoading
                      ? const OfferDetailsShimmer()
                      : Column(
                          children: [
                            CustomNetworkImage.containerNewWorkImage(
                              image: provider.model?.image ?? "",
                              height: 220.h,
                              width: context.width,
                              fit: BoxFit.cover,
                              radius: 20,
                            ),
                            const OfferDetailsBody(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                              child: CustomButton(
                                text: getTranslated("avail_the_offer", context),
                                onTap: () async {
                                  await launchUrl(
                                      Uri.parse(provider.model?.url ?? ""),
                                      mode: LaunchMode.externalApplication);
                                },
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class OfferDetailsShimmer extends StatelessWidget {
  const OfferDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      data: [
        CustomShimmerContainer(
          height: 220.h,
          radius: 20,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
          child: Row(
            children: [
              const CustomShimmerCircleImage(
                diameter: 56,
              ),
              SizedBox(
                width: 12.w,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerText(
                      width: 100,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CustomShimmerText(
                      width: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ///Store Offer
        const CustomShimmerText(
          width: 100,
        ),

        SizedBox(height: 8.h),

        ///Store Offer
        ...List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: CustomShimmerText(
              width: context.width,
            ),
          ),
        ),

        ///Offer Prices
        Padding(
          padding: EdgeInsets.only(
              bottom: 8.h, top: Dimensions.PADDING_SIZE_DEFAULT.h),
          child: const Row(
            children: [
              CustomShimmerText(
                width: 100,
              ),
              SizedBox(
                width: 4,
              ),
              CustomShimmerText(
                width: 100,
              ),
              Spacer(),
              CustomShimmerContainer(
                height: 30,
                width: 60,
                radius: 4,
              )
            ],
          ),
        ),

        ///Expired Date of Offer
        const CustomShimmerText(
          width: 200,
        ),
      ],
    );
  }
}
