import 'package:live/components/animated_widget.dart';
import 'package:live/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import '../../../data/config/di.dart';
import '../widgets/home_header.dart';
import '../widgets/home_places.dart';

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
      sl<HomeProvider>().scroll(controller);
      sl<HomeProvider>().getPlaces();
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
          Expanded(
            child: ListAnimator(
              controller: controller,
              data: const [HomeHeader(), HomePlaces()],
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
