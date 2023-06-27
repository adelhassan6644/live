import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/app/core/utils/text_styles.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import '../../../app/localization/provider/localization_provider.dart';
import '../../../components/custom_images.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({this.hint, this.withFilter = true, Key? key})
      : super(key: key);

  final bool withFilter;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Container(
          height: 38,
          decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  hint ?? getTranslated("search_for_delivery_offers", context),
                  style: AppTextStyles.w400.copyWith(
                      color: ColorResources.DISABLED,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      right: Provider.of<LocalizationProvider>(context,
                                  listen: false)
                              .isLtr
                          ? 0
                          : 10,
                      left: Provider.of<LocalizationProvider>(context,
                                  listen: false)
                              .isLtr
                          ? 10
                          : 0),
                  decoration: BoxDecoration(
                      border: Border(
                    right: Provider.of<LocalizationProvider>(context,
                                listen: false)
                            .isLtr
                        ? const BorderSide(color: Colors.transparent, width: 0)
                        : const BorderSide(
                            color: ColorResources.HINT_COLOR, width: 1),
                    left: Provider.of<LocalizationProvider>(context,
                                listen: false)
                            .isLtr
                        ? const BorderSide(
                            color: ColorResources.HINT_COLOR, width: 1)
                        : const BorderSide(color: Colors.transparent, width: 0),
                  )),
                  child: customImageIconSVG(
                    imageName: SvgImages.filter,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
