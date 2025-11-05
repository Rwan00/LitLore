import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/presentation/views/book_details_view.dart';

class BookImage extends StatelessWidget {
  final BookModel book;

  const BookImage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> context.push(BookDetailsView.routeName, extra: {"book": book}),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: AspectRatio(
          aspectRatio: 2.7 / 4,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: book.volumeInfo?.imageLinks?.smallThumbnail ?? "",
            errorWidget: (context, url, error) => const Icon(
              Icons.cloud_off,
              color: MyColors.kPrimaryColor,
              size: 36,
            ),
            placeholder: (context, url) => const Image(
              image: AssetImage(
                AppAssets.loading,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
