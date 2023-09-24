import 'package:flutter/material.dart';

class GalleryOverlay extends StatelessWidget {
  const GalleryOverlay({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.red,
            tooltip: 'Close',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}