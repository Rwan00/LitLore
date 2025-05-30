import 'package:flutter/material.dart';

import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/utils/app_assets.dart';
import '../theme/fonts.dart';

class CustomInputField extends StatefulWidget {
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? textType;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomInputField({
    this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.textType,
    this.isPassword = false,
    super.key,
    this.validator,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool showPwd = false;

  void changePasswordVisibility() {
    setState(() {
      showPwd = !showPwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: MyFonts.titleMediumStyle18,
          ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          validator: widget.validator,
          obscureText: widget.isPassword && !showPwd,
          controller: widget.controller,
          keyboardType: widget.textType,
          autofocus: false,
          style: MyFonts.subTiltleStyle14
              .copyWith(color: MyColors.kPrimaryColor),
          decoration: InputDecoration(
        
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: changePasswordVisibility,
                    icon: showPwd
                        ? Image.asset(AppAssets.openedBook)
                        : Image.asset(AppAssets.closedBook),
                  )
                : widget.widget,
            hintText: widget.hint,
            hintStyle: MyFonts.subTiltleStyle14,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: MyColors.kPrimaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
