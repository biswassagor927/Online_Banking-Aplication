import 'package:email_otp/email_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OtpSendOrVefy {
  EmailOTP myauth = EmailOTP();
  void sendOtp(email) async {
    try {
      myauth.setConfig(
          appEmail: "nirupay@nirupay.com",
          appName: "FASTMONEY",
          userEmail: email,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      if (await myauth.sendOTP() == true) {
        Fluttertoast.showToast(msg: 'OTP has been sent');
        print('OTP has been sent');
      } else {
        Fluttertoast.showToast(msg: 'Oops, OTP send failed');
        print('Oops, OTP send failed');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error: $e');
    }
  }

  void verifyOtp(var value, var send_screen) async {
    try {
      if ( myauth.verifyOTP(otp: value) == true) {
                Fluttertoast.showToast(msg: 'OTP is verified');
                
                Get.toNamed(send_screen);
              } else {
                Fluttertoast.showToast(msg: 'Invalid OTP');
                print('Invalid OTP');
              }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error: $e');
    }
  }
}
