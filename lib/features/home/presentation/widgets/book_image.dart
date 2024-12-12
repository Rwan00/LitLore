import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:litlore/core/utils/app_assets.dart';

class BookImage extends StatelessWidget {
  final String imgUrl;
  const BookImage({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: AspectRatio(
        aspectRatio: 2.7 / 4,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: imgUrl,
          errorWidget: (context, url, error) => const Image(
            image: AssetImage(
              AssetsData.error,
            ),
            
          ),
          placeholder: (context, url) => const Image(
            image: AssetImage(
              AssetsData.loading,
            ),
          ),
        ),
      ),
    );
  }
}
