import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/features/authentication/presentation/widgets/background_stack_image.dart';

class CustomContainerWidget extends StatelessWidget {
  final double containerHeight;
  final Widget child;
  const CustomContainerWidget(
      {super.key, required this.containerHeight, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        const BackgroundStackImage(),
        SizedBox(
          height: containerHeight,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: MyColors.kScaffoldColor,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
