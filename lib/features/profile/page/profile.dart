import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/profile_provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return const SafeArea(
        bottom: true,
        top: false,
        child: SizedBox(),
      );
    });
  }
}
