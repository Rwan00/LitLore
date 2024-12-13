

import 'package:flutter/material.dart';

import '../utils/app_assets.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        image: AssetImage(
          AssetsData.loadingBook,
        ),
      ),
    );
  }
}