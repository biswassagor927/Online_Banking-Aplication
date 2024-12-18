import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:online_mobile_banking_system/ui/views/auth/email_verify.dart';

import '../../../business_logics/auth.dart';
import '../../styles/style.dart';
import '../../widgets/button.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();

  RxBool passVisibility = false.obs;

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 199, 29, 179),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, right: 15.w, left: 15.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(loginSignUpScreen),
                      child: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/img/back.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      'Let’s Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Create\n Account!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    } else {
                      return null;
                    }
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppStyle().myTextForm,
                  decoration: AppStyle().textFieldDecoration(
                    'Enter Email',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                        () => TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passController,
                          obscureText: !passVisibility.value,
                          maxLength: 12,
                          style: AppStyle().myTextForm,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "this field can't be empty";
                            } else if (val.length < 8) {
                              return "Minimum 8 Digit Password";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter 8 dight password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  passVisibility.value = !passVisibility.value;
                                },
                                icon: Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                  size: 15.sp,
                                )),
                            filled: true,
                            fillColor: Color(0xFF202244),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide.none),
                            hintStyle: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20.h,
                ),
                Button(
                    text: "Sign Up",
                    onAction: () {
                      
                      if(_passController.text.length <8){
                        Fluttertoast.showToast(msg: 'minimum 8 digit');
                      }else{
                        box.write('passw', _passController.text);
                      Get.to(EmailVerify(_emailController.text));

                      }
                      // _emailController.text.length == 0 &&
                      //         _emailController.text.length == 0
                      //     ? Fluttertoast.showToast(msg: 'this field empty')
                      //     : Auth().registration(_emailController.text,
                      //         _passController.text, context);
                    }),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                          children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA898F6),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(loginScreen),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
