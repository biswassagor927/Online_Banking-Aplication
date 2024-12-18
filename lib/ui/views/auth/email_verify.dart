import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/auth.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:online_mobile_banking_system/business_logics/emil_otp.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import '../../styles/style.dart';
import '../../widgets/button.dart';

class EmailVerify extends StatefulWidget {
  String email;

  EmailVerify(this.email);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final box = GetStorage();
  EmailOTP myauth = EmailOTP();

  @override
  void initState() {
    _email.text = widget.email;
    super.initState();
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 1, 3),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, right: 15.w, left: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/back.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  width: 60.w,
                ),
                Text(
                  'Verification Code',
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
              'Enter the code we sent you',
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
              //readOnly: true,
              style: TextStyle(color: Colors.white),
              decoration: AppStyle().textFieldDecoration(
                'Enter Email',
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            InkWell(
              onTap: () async {
                //EmailOtp().sendOtp(_email.text);
                myauth.setConfig(
                    appEmail: "nirupay@nirupay.com",
                    appName: "FASTMONEY",
                    userEmail: _email.text,
                    otpLength: 4,
                    otpType: OTPType.digitsOnly);
                if (await myauth.sendOTP() == true) {
                  Fluttertoast.showToast(msg: 'OTP has been sent');
                  print('OTP has been sent');
                } else {
                  Fluttertoast.showToast(msg: 'Oops, OTP send failed');
                  print('Oops, OTP send failed');
                }
              },
              child: Text(
                'Sent Code',
                style: TextStyle(
                  color: Color(0xFFA898F6),
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            PinCodeTextField(
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.white,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],

              //backgroundColor: Colors.white,
              controller: _otpController,
              appContext: context,
              length: 4,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal),
              onChanged: (value) {},
              onCompleted: (value) {
                // EmailOtp().verifyOTP(_email.text);
                if (myauth.verifyOTP(otp: value) == true) {
                  var _passW = box.read('passw');
                  Fluttertoast.showToast(msg: 'OTP is verified');
                  Future.delayed(Duration(seconds: 2), () {
                    Auth().registration(_email.text, _passW, context);
                  });
                } else {
                  Fluttertoast.showToast(msg: 'Invalid OTP');
                  print('Invalid OTP');
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
