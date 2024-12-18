import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailOtp {
  //final box = GetStorage();

  Future<void> sendOtp(String email) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://nirupay.com',
          handleCodeInApp: true,
        ),
      );
      print('OTP Email Sent to ${email}');
    } catch (e) {
      print('Error sending OTP email: $e');
    }
  }

  Future<void> verifyOTP(String email) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signInWithEmailLink(
        email: email,
        emailLink: 'https://nirupay.com',
      );
      print('OTP Verification Successful');
    } catch (e) {
      print('OTP Verification Failed: $e');
    }
  }

  // void SendOtp(String email) async {
  //   //var email = await box.read('email');
  //   //EmailAuth.sessionName = 'Nirpay';
  //   var res = await EmailAuth(sessionName: 'Nirpay').sendOtp(recipientMail: email, otpLength: 6);
  //   if (res) {
  //     Fluttertoast.showToast(msg: 'OTP Send');
  //   } else {
  //     Fluttertoast.showToast(msg: 'We Could Not Net OTP');
  //   }
  // }

  // void OtpVerify(var userOTP, String email) async {
  //   //var email = await box.read('email');
  //   EmailAuth.sessionName = 'Nirpay';
  //   var res = await EmailAuth.validate(receiverMail: email, userOTP: userOTP);
  //   if (res) {
  //     Fluttertoast.showToast(msg: 'Verify Successfull');
  //     Get.offNamed(loginScreen);
  //   } else {
  //     Fluttertoast.showToast(msg: 'Worg Code');
  //   }
  // }
}
