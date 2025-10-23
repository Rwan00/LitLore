import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/presentation/widgets/book_details_view_body.dart';

class BookDetailsView extends StatelessWidget {
  static const routeName = "/BookDetailsView";
  final BookModel book;
  const BookDetailsView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border_outlined, size: 28),
          ),
        ],
      ),
      body: BookDetailsViewBody(book: book),
    );
  }
}
