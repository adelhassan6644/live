import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/components/animated_widget.dart';
import 'package:live/components/empty_widget.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:live/features/favourite/provider/favourite_provider.dart';
import 'package:live/features/guest/guest_mode.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/grid_list_animator.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/place_card.dart';
import '../provider/search_provider.dart';
import '../repo/search_repo.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(searchRepo: sl<SearchRepo>()),
      child: Scaffold(
        body: Consumer<SearchProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              bottom: true,
              top: true,
              child: Column(
                children: [
                  const CustomAppBar(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("البحث",
                              style: AppTextStyles.semiBold.copyWith(
                                  fontSize: 24, color: ColorResources.HEADER)),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  controller: provider.searchTEC,
                                  hint: " ابحث هنا",
                                  pIconColor: Colors.black38,
                                  keyboardAction: TextInputAction.search,
                                  inputType: TextInputType.name,
                                  pSvgIcon: Images.search,
                                  autofocus: true,
                                  onSaved: (v) {
                                    provider.search();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 27.5 * 2,
                                width: 27.5 * 2,
                                padding: const EdgeInsets.all(0),
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: InkWell(
                                  onTap: () {
                                    provider.search();
                                  },
                                  child: CircleAvatar(
                                    radius: 27.5,
                                    backgroundColor:
                                        ColorResources.SECOUND_PRIMARY_COLOR,
                                    child: SvgPicture.asset(Images.search),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: provider.isLoading
                                  ? GridListAnimatorWidget(
                                      items: List.generate(
                                        8,
                                        (int index) {
                                          return AnimationConfiguration
                                              .staggeredGrid(
                                                  columnCount: 2,
                                                  position: index,
                                                  duration: const Duration(
                                                      milliseconds: 375),
                                                  child: const ScaleAnimation(
                                                      child: FadeInAnimation(
                                                          child:
                                                              CustomShimmerContainer())));
                                        },
                                      ),
                                    )
                                  : provider.placesModel != null &&
                                          provider.placesModel!.data != null &&
                                          provider.placesModel!.data!.isNotEmpty
                                      ? GridListAnimatorWidget(
                                          items: List.generate(
                                            provider.placesModel!.data!.length,
                                            (int index) {
                                              return AnimationConfiguration
                                                  .staggeredGrid(
                                                      columnCount: 2,
                                                      position: index,
                                                      duration: const Duration(
                                                          milliseconds: 375),
                                                      child: ScaleAnimation(
                                                          child:
                                                              FadeInAnimation(
                                                                  child:
                                                                      PlaceCard(
                                                        place: provider
                                                            .placesModel!
                                                            .data![index],
                                                      ))));
                                            },
                                          ),
                                        )
                                      : provider.searchTEC.text == ""
                                          ? Center(
                                            child: ListAnimator(
                                                data: [
                                                  Center(
                                                    child: EmptyState(
                                                      imgWidth: 215.w,
                                                      imgHeight: 180.h,
                                                      img: Images.emptySearch2,
                                                      imgColor: ColorResources
                                                          .BORDER_COLOR,
                                                      isSvg: false,
                                                      spaceBtw: 12,
                                                      txtColor:
                                                          ColorResources.DISABLED,
                                                      txt:
                                                          "قم بالبحث عن المكان الذي تريدة",
                                                      subText: "",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          )
                                          : ListAnimator(
                                              data: [
                                                Center(
                                                  child: EmptyState(
                                                    imgWidth: 215.w,
                                                    imgHeight: 220.h,
                                                    img: Images.emptySearch,
                                                    isSvg: false,
                                                    spaceBtw: 12,
                                                    txtColor:
                                                        ColorResources.DISABLED,
                                                    txt:
                                                        "لا يوجد لدينا مكان بنفس هذا العنوان قم بتجربة كلمة بحث مختلفة",
                                                    subText: "",
                                                  ),
                                                ),
                                              ],
                                            ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
