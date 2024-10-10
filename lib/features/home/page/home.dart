import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/core/utils/svg_images.dart';
import 'package:live/components/animated_widget.dart';
import 'package:live/components/custom_images.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../contact_with_us/provider/contact_provider.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_header.dart';
import '../widgets/home_news.dart';
import '../widgets/home_offers.dart';
import '../widgets/home_banners.dart';
import '../widgets/home_places.dart';
import '../widgets/home_search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      print(
          "sectioss ${Provider.of<ContactProvider>(CustomNavigator.navigatorState.currentContext!, listen: false).contactModel?.sections}");
      sl<HomeProvider>().scroll(controller);
      sl<HomeProvider>().getBanners();
      sl<HomeProvider>().getPlaces();
      sl<HomeProvider>().getCategories();
      sl<HomeProvider>().getOffers();
      sl<HomeProvider>().getNews();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: RefreshIndicator(
              color: ColorResources.PRIMARY_COLOR,
              onRefresh: () async {
                // sl<HomeProvider>().show = false;
                sl<HomeProvider>().getPlaces();
                sl<HomeProvider>().getCategories();
                sl<HomeProvider>().getOffers();
                sl<HomeProvider>().getNews();
              },
              child: Consumer<ContactProvider>(
                  builder: (context, contactProvider, _) {
                return ListView(
                  controller: controller,
                  children: [
                    ...?contactProvider.contactModel?.sections,


                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
