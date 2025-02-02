import 'package:flutter/material.dart';

import 'package:litlore/core/theme/colors.dart';


import '../theme/fonts.dart';

class CustomInputField extends StatelessWidget {
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? textType;
  final bool isPassword;

  const CustomInputField(
      {this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.textType,
      this.isPassword = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    
        
        //bool showPwd = cubit.showPwd;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: MyFonts.titleMediumStyle18,
              ),
            const SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
               // obscureText: isPassword && !showPwd,
                controller: controller,
                keyboardType: textType,
                autofocus: false,
                style: MyFonts.titleMediumStyle18,
                cursorColor: MyColors.kPrimaryColor,
                decoration: InputDecoration(
                  suffixIcon: isPassword
                      ? IconButton(
                          onPressed: () {
                           // cubit.changePasswordVisibility();
                          },
                          icon: Icon(Icons.visibility),
                        )
                      : widget,
                  hintText: hint,
                  hintStyle: MyFonts.subTiltleStyle14,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: MyColors.kPrimaryColor,
                        width: 2,
                      )),
                ),
              ),
            ),
          ],
        );
      
    
  }
}
