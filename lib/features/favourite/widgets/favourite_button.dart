import 'package:flutter/material.dart';
import 'package:live/features/favourite/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_images.dart';

class FavouriteButton extends StatelessWidget {
  final int? id;

  const FavouriteButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteProvider>(
      builder: (_, provider, child) {
        bool isFav = false;
        isFav = provider.favouriteId.indexWhere((e) => e == id) != -1;
        return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            radius: 10,
            onTap: () => provider.updateFavourites(id: id!),
            child: customImageIconSVG(
                imageName:
                    isFav ? SvgImages.favourite : SvgImages.disFavourite));
      },
    );
  }
}
