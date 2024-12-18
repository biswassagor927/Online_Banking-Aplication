import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/business_logics/send_otp_vefy_otp.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../styles/style.dart';
import '../../widgets/button.dart';

class ForgetPass extends StatelessWidget {
  TextEditingController _email = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 38, 181),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, right: 15.w, left: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap:() => Get.toNamed(loginScreen),
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
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'We need your email to send link to forget your password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            TextFormField(
              controller: _email,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: AppStyle().textFieldDecoration(
                'Enter Old Email',
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Button(
              text: 'Send Link',
              onAction: () async {
                // myauth.setConfig(
                //     appEmail: "nirupay@nirupay.com",
                //     appName: "NiruPay",
                //     userEmail: _email.text,
                //     otpLength: 4,
                //     otpType: OTPType.digitsOnly);
                // if (await myauth.sendOTP() == true) {
                //   Fluttertoast.showToast(msg: 'OTP has been sent');
                //   print('OTP has been sent');
                // } else {
                //   Fluttertoast.showToast(msg: 'Oops, OTP send failed');
                //   print('Oops, OTP send failed');
                // }
                //Send Otp
                
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text,).whenComplete(() =>Fluttertoast.showToast(msg: 'Link sent successful'));
                } catch (e) {
                  Fluttertoast.showToast(msg: 'Oops, $e');
                }
              },
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // PinCodeTextField(
            //    pinTheme: PinTheme(
            //           shape: PinCodeFieldShape.box,
            //           borderRadius: BorderRadius.circular(5),
            //           fieldHeight: 50,
            //           fieldWidth: 40,
            //           activeFillColor: Colors.white,
            //         ),
            //         pastedTextStyle: TextStyle(
            //           color: Colors.green.shade600,
            //           fontWeight: FontWeight.bold,
            //         ),
            //         cursorColor: Colors.white,
            //         keyboardType: TextInputType.number,
            //         boxShadows: const [
            //           BoxShadow(
            //             offset: Offset(0, 1),
            //             color: Colors.black12,
            //             blurRadius: 10,
            //           )
            //         ],
              
            //   //backgroundColor: Colors.white,
            //   controller: _otpController,
            //   appContext: context,
            //   length: 4,
            //   textStyle: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.normal
            //   ),
            //   onChanged: (value) {},
            //   onCompleted: (value) {
            //    // EmailOtp().verifyOTP(_email.text);
            //    if ( myauth.verifyOTP(otp: value) == true) {
            //     Fluttertoast.showToast(msg: 'OTP is verified');
                
            //     Get.toNamed(resetpassScreen);
            //   } else {
            //     Fluttertoast.showToast(msg: 'Invalid OTP');
            //     print('Invalid OTP');
            //   }
            //   },
            // ),
          ],
        ),
      ),
    ));
  }
}
