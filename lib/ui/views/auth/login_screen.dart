import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/auth.dart';
import 'package:online_mobile_banking_system/business_logics/email_vali.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:online_mobile_banking_system/ui/widgets/button.dart';

import '../../../business_logics/emil_otp.dart';
import '../../styles/style.dart';

class SignIn extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();
  StaticPageController min = Get.put(StaticPageController());
  int failedLoginAttemps = 0;
  RxBool passVisibility = false.obs;
  EmailOTP myauth = EmailOTP();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 213, 40, 202),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, right: 15.w, left: 15.w),
        child: SingleChildScrollView(
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
                    'Let’s Sign In',
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
                'Welcome\n Back!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 50.h,
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: ((value) => EmailVal().validateEmail(value)),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: AppStyle().myTextForm,
                        decoration: AppStyle().textFieldDecoration(
                          'Enter Email',
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
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
                          text: 'Sign In',
                          onAction: () {
                            box.write('email', _emailController.text);
                            _emailController.text.length == 0 &&
                                    _emailController.text.length == 0
                                ? Fluttertoast.showToast(
                                    msg: 'this field empty')
                                : Auth().login(_emailController.text,
                                    _passController.text, context);
                            _emailController.text.length == 0 &&
                                    _emailController.text.length == 0
                                ? Fluttertoast.showToast(
                                    msg: 'this field empty')
                                : failedLoginAttemps++;
                            print(failedLoginAttemps);
                            if (failedLoginAttemps == 3) {
                              //EmailOtp().sendOtp(_emailController.text);
                               myauth.setConfig(
                              appEmail: "nirupay@nirypay.com",
                              appName: "Email OTP",
                              userEmail: _emailController.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                              //
                              Get.offNamed(emailVerifiScreen);
                            }
                          }),
                    ],
                  )),

              SizedBox(
                height: 15.h,
              ),    

              InkWell(
                onTap: () => Get.toNamed(forgetScreen),
                child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 25.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            'Forget Password',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF030303),
                            ),
                          ),
                        ),
                      ),
                    ),
              ),    
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                        text: "Don’t have registered yet? ",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                        children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA898F6),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(signUpScreen),
                      )
                    ])),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
