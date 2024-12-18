import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';

class SignInSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 208, 24, 165),
        body: Padding(
          padding: EdgeInsets.only(right: 20.w, left: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(onbording),
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/back3.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70.w,
                  ),
                  Container(
                    height: 112.h,
                    width: 119.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      image: DecorationImage(
                          image: AssetImage('assets/logo/Firt Money.png.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(50.0),
                child: Image.asset(
                  'assets/img/onbording3.png',
                  height: 300,
                ),
              ),
              Container(
                width: double.infinity,
                height: 44.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 201, 40, 179)),
                  onPressed: () => Get.toNamed(loginScreen),
                  child: Text('Sign In',style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                height: 44.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 228, 41, 231),
                      elevation: 0,
                      side: BorderSide(
                        color: Colors.white,
                      )),
                  onPressed: () => Get.toNamed(signUpScreen),
                  child: Text('Sign Up',style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
