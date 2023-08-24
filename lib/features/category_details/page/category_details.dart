import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:live/app/core/utils/extensions.dart';
import 'package:live/components/animated_widget.dart';
import 'package:live/components/empty_widget.dart';
import 'package:live/components/shimmer/custom_shimmer.dart';
import 'package:live/features/category_details/provider/category_details_provider.dart';
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

class _CategoryDetailsState extends State<CategoryDetails>with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _tabController = TabController(
          initialIndex: 0,
          length:   Provider.of<CategoryDetailsProvider>(context, listen: false).currentCategory!.subCategory!.isNotEmpty? Provider.of<CategoryDetailsProvider>(context, listen: false).currentCategory!.subCategory!.length :0,
          vsync: this);
      Provider.of<CategoryDetailsProvider>(context, listen: false).model = null;
      if(Provider.of<CategoryDetailsProvider>(context, listen: false).currentCategory!.subCategory!.isEmpty) {
        Provider.of<CategoryDetailsProvider>(context, listen: false)
          .getCategoryDetails(widget.id);
      }
      else{
        Provider.of<CategoryDetailsProvider>(context, listen: false)
            .getSubCategoryDetails(Provider.of<CategoryDetailsProvider>(context, listen: false).currentCategory!.subCategory!.first.id);
      }
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
                  child:  Text(provider.currentCategory?.title ?? "",
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 24,
                              color: provider.currentCategory!.textColor?.toColor)),
                ),
                SizedBox(
                  height: 50,
                  width: context.width,
                  child: TabBar(
                    labelColor:
                    Theme.of(context).textTheme.bodyLarge!.color,
                    unselectedLabelColor: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.5),
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _tabs(provider),

                    onTap: (int index) {

                        provider.selectTab( index);

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
  List<Tab> _tabs(CategoryDetailsProvider category) {
    List<Tab> tabList = [];
    if (category.currentCategory!.subCategory!.isNotEmpty) {

      category.currentCategory!.subCategory!
          .forEach((subCategory) => tabList.add(Tab(text: subCategory.title??"")));
    } else {

    }

    return tabList;
  }
}
