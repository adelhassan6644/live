import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live/app/core/utils/dimensions.dart';
import 'package:map_launcher/map_launcher.dart';

class MapsSheet {
  static show({
    required BuildContext context,
    required Function(AvailableMap map) onMapTap,
  }) async {
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          bottom: true,
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
                            .circular(
                            100)),
                    child: const SizedBox(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: <Widget>[
                      for (var map in availableMaps)
                        ListTile(
                          onTap: () => onMapTap(map),
                          title: Text(map.mapName),
                          leading: ClipOval(
                            child: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
