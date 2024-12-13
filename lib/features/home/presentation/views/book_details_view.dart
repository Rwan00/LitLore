import 'package:flutter/material.dart';
import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/presentation/widgets/book_details_view_body.dart';

class BookDetailsView extends StatelessWidget {
  static const routeName = "Book Details View";
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)?.settings.arguments as BookModel;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            viewPop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star_border_outlined,
              size: 28,
            ),
          ),
        ],
      ),
      body: BookDetailsViewBody(
      book: book,
      ),
    );
  }
}
