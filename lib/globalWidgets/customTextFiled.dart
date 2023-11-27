import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.hinttext,
    this.controllers,
    this.validators,
    this.onTap,
    this.keyboardTyp,
    this.inputFormater,
    this.onChanged,
    this.readOnly,
  }) : super(key: key);
  final onTap;
  final hinttext;
  final controllers;
  final validators;
  final keyboardTyp;
  final inputFormater;
  final onChanged;
 final readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(boxShadow: [tBoxShadow]),
      height: 55,
      child: TextFormField(
        readOnly: readOnly,
        onChanged: onChanged,
        style: GoogleFonts.mulish(
            fontSize: isTab(context) ? 9.sp : 12.sp,
            fontWeight: FontWeight.w500,
            color: tSecondaryColor),
        controller: controllers,
        validator: validators,
        keyboardType: keyboardTyp,
        inputFormatters: inputFormater,
        decoration: InputDecoration(
          fillColor: tWhite,
          filled: true,
          hintText: hinttext,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: tPrimaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: tPrimaryColor),
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(tDefaultPadding / 2),
          // ),
        ),
      ),
    );
  }
}
