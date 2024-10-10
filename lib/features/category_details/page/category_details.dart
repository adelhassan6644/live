import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/components/animated_widget.dart';
import 'package:live/components/custom_button.dart';
import 'package:live/components/empty_widget.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:live/features/category_details/provider/category_details_provider.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/grid_list_animator.dart';
import '../../../components/tab_widget.dart';
import '../../../main_widgets/place_card.dart';

class CategoryDetails extends StatefulWidget {
  final int id;
  const CategoryDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _tabController = TabController(
          initialIndex: 0,
          length: Provider.of<CategoryDetailsProvider>(context, listen: false)
                  .currentCategory!
                  .subCategory!
                  .isNotEmpty
              ? Provider.of<CategoryDetailsProvider>(context, listen: false)
                      .currentCategory!
                      .subCategory!
                      .length +
                  1
              : 0,
          vsync: this);
      Provider.of<CategoryDetailsProvider>(context, listen: false).model = null;
      // if (Provider.of<CategoryDetailsProvider>(context, listen: false)
      //     .currentCategory!
      //     .subCategory!
      //     .isEmpty)
      {
        Provider.of<CategoryDetailsProvider>(context, listen: false)
            .getCategoryDetails(widget.id);
      }
      // else {
      //   Provider.of<CategoryDetailsProvider>(context, listen: false)
      //       .getSubCategoryDetails(
      //           Provider.of<CategoryDetailsProvider>(context, listen: false)
      //               .currentCategory!
      //               .subCategory!
      //               .first
      //               .id);
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Consumer<CategoryDetailsProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: Row(
                    children: [
                      Text(provider.currentCategory?.title ?? "",
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 24,
                              color: provider
                                  .currentCategory!.textColor?.toColor)),
                      Spacer(),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorResources.SECOUND_PRIMARY_COLOR),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,

                                    builder: (BuildContext context) {
                                      return Consumer<CategoryDetailsProvider>(
                                        builder: (context,provider,_) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.horizontal(
                                                  left: Radius.circular(10),
                                                  right: Radius.circular(10)),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: Container(
                                                      height: 5.h,
                                                      width: 36.w,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                                  0xFF3C3C43)
                                                              .withOpacity(0.3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(100)),
                                                      child: const SizedBox(),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "ترتيب العروض",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      Wrap(
                                                        children: [
                                                          fillterContainer(
                                                              icon: false,
                                                              text: "احدث العروض",
                                                              isSelect: provider.latestOffer==true,
                                                              onTap: () {
                                                                provider.setLatestOffer(true);
                                                              }),
                                                          fillterContainer(
                                                              text: "الجميع",
                                                              icon: false,
                                                              isSelect: provider.latestOffer==false,
                                                              onTap: () {
                                                                provider.setLatestOffer(false);

                                                              }),
                                                        ],
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     Text(
                                                      //       "العروض",
                                                      //       style: TextStyle(
                                                      //           fontSize: 20,
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w600),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      // Wrap(
                                                      //   children: [
                                                      //     fillterContainer(
                                                      //       icon: false,
                                                      //         text: "الاماكن التي لديها عروض",
                                                      //         isSelect: provider.offer==true,
                                                      //         onTap: () {
                                                      //           provider.setOffer(true);
                                                      //         }),
                                                      //     fillterContainer(
                                                      //         text: "الجميع",
                                                      //         icon: false,
                                                      //         isSelect: provider.offer==false,
                                                      //         onTap: () {
                                                      //           provider.setOffer(false);
                                                      //
                                                      //         }),
                                                      //   ],
                                                      // ),

                                                      Row(
                                                        children: [
                                                          Text(
                                                            "الموقع",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      Wrap(
                                                        children: [
                                                          fillterContainer(
                                                              text: "الأقرب إلي",
                                                              icon: false,
                                                              isSelect: provider.nearset==true,
                                                              onTap: () {
                                                                provider.setCurrentUserPosition(true);
                                                              }),
                                                          fillterContainer(
                                                              text: "الجميع",
                                                              icon: false,
                                                              isSelect: provider.nearset==false,
                                                              onTap: () {
                                                                provider.setCurrentUserPosition(false);

                                                              }),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "التقيم",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      Wrap(
                                                        children: [
                                                          fillterContainer(
                                                              text: "4 واكثر",
                                                              isSelect: provider.rate==4,
                                                              onTap: () {
                                                                provider.setCurrentRate(4);

                                                              }),
                                                          fillterContainer(
                                                              text: "3 واكثر",
                                                              isSelect: provider.rate==3,
                                                              onTap: () {
                                                                provider.setCurrentRate(3);
                                                              }),
                                                          fillterContainer(
                                                              text: "2 واكثر",
                                                              isSelect: provider.rate==2,
                                                              onTap: () {
                                                                provider.setCurrentRate(2);
                                                              }),
                                                          fillterContainer(
                                                              text: "الجميع",
                                                              isSelect: provider.rate==0,
                                                              onTap: () {
                                                                provider.setCurrentRate(0);
                                                              }),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: CustomButton(
                                                            text: 'تعين',
                                                                onTap: (){
                                                                  CustomNavigator
                                                                      .pop();
                                                                  provider.submitFilter();

                                                                },
                                                          )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: InkWell(
                                                              onTap: () {
                                                                provider.restFilter();
                                                                CustomNavigator
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                "إلغاء",
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: ColorResources
                                                                        .SECOUND_PRIMARY_COLOR,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.filter_alt_outlined,
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: context.width,
                  child: TabBar(
                    labelColor: Theme.of(context).textTheme.bodyLarge!.color,
                    unselectedLabelColor: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.5),
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _tabs(provider),

                    onTap: (int index) {
                      if (index == 0) {
                        provider.selectTab(index );
                        provider.getCategoryDetails(widget.id);
                      } else {
                        provider.selectTab(index );
                      }
                    },
                    // provider.subCategories.map((e) => Tab(text: e.name)).toList(),
                  ),
                ),
                provider.isLoading
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: GridListAnimatorWidget(
                            items: List.generate(
                              8,
                              (int index) {
                                return AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: const ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: CustomShimmerContainer(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : provider.model != null &&
                            provider.model!.data != null &&
                            provider.model!.data!.places != null &&
                            provider.model!.data!.places != null &&
                            provider.model!.data!.places!.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_DEFAULT.w),
                              child: GridListAnimatorWidget(
                                items: List.generate(
                                  provider.model!.data!.places!.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      columnCount: 2,
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: PlaceCard(
                                            place: provider
                                                .model!.data!.places![index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              color: ColorResources.PRIMARY_COLOR,
                              onRefresh: () async {
                                provider.getCategoryDetails(widget.id);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT.w),
                                child: ListAnimator(
                                  data: [
                                    EmptyState(
                                      imgWidth: 215.w,
                                      imgHeight: 220.h,
                                      spaceBtw: 12,
                                      txt: "لا يوجد اماكن الان",
                                      subText: "اكتشف معانا اماكن جديدة",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
              ],
            );
          },
        ),
      ),
    );
  }

  fillterContainer({bool icon = true,bool isSelect = true, text, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color:isSelect? ColorResources.PRIMARY_COLOR:Colors.transparent),
              color: Colors.grey.withOpacity(.1),
              borderRadius: BorderRadius.circular(22)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon)
                  Icon(
                    Icons.star_border,
                    color: Colors.amberAccent,
                  ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Tab> _tabs(CategoryDetailsProvider category) {
    List<Tab> tabList = [];
    if (category.currentCategory!.subCategory!.isNotEmpty) {
      tabList.add(const Tab(text: 'الكل'));
      for (var subCategory in category.currentCategory!.subCategory!) {
        tabList.add(Tab(text: subCategory.title ?? ""));
      }
    } else {}

    return tabList;
  }
}
