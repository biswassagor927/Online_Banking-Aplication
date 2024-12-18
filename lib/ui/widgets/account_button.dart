import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_mobile_banking_system/const/app_colors.dart';

class AccountButton extends StatefulWidget {
  Function onAction;
  String text;
  IconData icon;
  IconData iconlast;

  AccountButton(
      {required this.text,
      required this.onAction,
      required this.icon,
      required this.iconlast});

  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.onAction();
        });
      },
      child: Container(
        height: 48.h,
        padding: EdgeInsets.only(right: 10.w, left: 10.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 215, 16, 115),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  widget.icon,
                  color: AppColors.iconCol,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  widget.iconlast,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
