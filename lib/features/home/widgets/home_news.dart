import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/components/custom_images.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class HomeNews extends StatelessWidget {
  const HomeNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          ),
          child: Text(
            "أخر الأخبار ",
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 24, color: ColorResources.HEADER),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Consumer<HomeProvider>(builder: (context, provider, child) {
          return provider.isExploring
              ? const _NewsShimmer()
              : provider.newsModel != null &&
                      provider.newsModel?.news != null &&
                      provider.newsModel!.news!.isNotEmpty
                  ? Column(
                      children: List.generate(
                          provider.newsModel?.news?.length != 0 ? 1 : 0,
                          (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 16.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 16.h),
                                      decoration: BoxDecoration(
                                          color: ColorResources.WHITE_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(2, 2),
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 10)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.newsModel?.news?[index]
                                                    .title ??
                                                "",
                                            style:
                                                AppTextStyles.medium.copyWith(
                                              fontSize: 22,
                                              color: ColorResources.TITLE,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          HtmlWidget(
                                            provider.newsModel?.news?[index]
                                                .content ??
                                                "",
                                            textStyle: AppTextStyles.medium.copyWith(
                                              fontSize: 16,
                                              color: ColorResources.DETAILS_COLOR,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 18.h,
                                          ),
                                          Row(
                                            children: [
                                              customImageIconSVG(
                                                  imageName: SvgImages.location,
                                                  height: 20,
                                                  width: 20,
                                                  color: ColorResources.TITLE),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  provider
                                                          .newsModel
                                                          ?.news?[index]
                                                          .address ??
                                                      "address",
                                                  maxLines: 1,
                                                  style: AppTextStyles.medium
                                                      .copyWith(
                                                          fontSize: 16,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: ColorResources
                                                              .TITLE),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          CustomNetworkImage
                                              .containerNewWorkImage(
                                                  image:  provider
                                                      .newsModel
                                                      ?.news?[index]
                                                          .image ??
                                                      "",
                                                  width: context.width,
                                                  height: 180.h,
                                                  fit: BoxFit.cover,
                                                  radius: 20),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      // visible: !provider.show,
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        onTap: () =>
                                            CustomNavigator.push(Routes.NEWS),
                                        child: Row(
                                          children: [
                                            const Expanded(child: SizedBox()),
                                            Text(
                                              "المزيد من الأخبار",
                                              style: AppTextStyles.medium
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: ColorResources
                                                          .DETAILS_COLOR),
                                            ),
                                            customImageIconSVG(
                                                imageName:
                                                    SvgImages.arrowRightIcon,
                                                color: ColorResources
                                                    .DETAILS_COLOR),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                    )
                  : const EmptyState(
                      emptyHeight: 200,
                      imgHeight: 110,
                    );
        }),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}

class _NewsShimmer extends StatelessWidget {
  const _NewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: CustomShimmerContainer(
          radius: 20,
          height: 335.h,
          width: context.width,
        ));
  }
}
