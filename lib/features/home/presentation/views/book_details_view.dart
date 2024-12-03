import 'package:flutter/material.dart';
import 'package:litlore/features/home/presentation/widgets/book_details_view_body.dart';

class BookDetailsView extends StatelessWidget {
  static const routeName = "Book Details View";
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final imgUrl = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
        imgUrl: imgUrl,
      ),
    );
  }
}
