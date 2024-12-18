import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  Function onAction;
  String text;

  Button({required this.text, required this.onAction});

  RxBool isLoading = false.obs;
  RxBool buttonEnabled = true.obs;

  void _handleButtonTap() {
    if (!buttonEnabled.value) {
      return;
    }
    isLoading.value = true;
    buttonEnabled.value = false; // Simulate a time-consuming task
    Future.delayed(Duration(seconds: 3), () {
      isLoading.value = false;
      buttonEnabled.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () {
            buttonEnabled == true ? onAction() : null;
            //onAction();
            _handleButtonTap();
          },
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3F3D9B),
                  Color(0xFF6C6CC9),
                ],
              ),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: isLoading.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Please Wait',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Transform.scale(
                          scale: 0.4,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                    ],
                  )
                : Center(
                    child: Text(text,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ))),
          ),
        ));
  }
}
