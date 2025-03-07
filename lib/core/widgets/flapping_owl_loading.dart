import 'package:flutter/material.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';

class FlappingOwlLoading extends StatefulWidget {
  const FlappingOwlLoading({super.key});

  @override
  State<FlappingOwlLoading> createState() => _FlappingOwlLoadingState();
}

class _FlappingOwlLoadingState extends State<FlappingOwlLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: Tween(begin: -0.1, end: 0.1).animate(_controller),
          child: Image.asset(
            AppAssets.owlLoading,
            height: 50,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Owl says: 'Patience, young reader!'",
          style: MyFonts.subTiltleStyle14,
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Usage:
