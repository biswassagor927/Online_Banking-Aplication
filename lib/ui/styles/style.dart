import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  TextStyle myTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );
  TextStyle myTextForm = TextStyle(
      color: Colors.white
  );

  InputDecoration textFieldDecoration( hint, [icon]) => InputDecoration(
        hintText: hint,

        suffixIcon: Icon(
          icon,
          color: Colors.white,
          size: 15.sp,
        ),
        filled: true,
        fillColor: Color(0xFF202244),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none),
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: Colors.white,
        ),
      );
}
