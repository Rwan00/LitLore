import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';

class DrawerItem extends StatelessWidget {
  final int count;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    required this.count,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MyColors.kPrimaryColor.withAlpha(30),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(count.toString()),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
