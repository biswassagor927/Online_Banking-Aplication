import 'package:get/get.dart';
import 'package:online_mobile_banking_system/ui/views/auth/change_password.dart';
import 'package:online_mobile_banking_system/ui/views/auth/forgot_password.dart';
import 'package:online_mobile_banking_system/ui/views/auth/login_screen.dart';
import 'package:online_mobile_banking_system/ui/views/auth/verification_code.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/bottom_nav_contoler.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/bill/bill.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/bill/electry_bill.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/bill/green_un.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/top_up/top_up.dart';
import 'package:online_mobile_banking_system/ui/views/onbordingpage.dart';
import 'package:online_mobile_banking_system/ui/views/pin_lock.dart';
import 'package:online_mobile_banking_system/ui/views/send_money.dart';
import 'package:online_mobile_banking_system/ui/views/user_form.dart';

import '../views/auth/sign_in_sign_up.dart';
import '../views/auth/sign_up_with_email_pass.dart';
import '../views/splash_screen.dart';

const String splash = '/splash-screen';
const String onbording = '/onbording-screen';

const String homeScreen = '/home-screen';
const String loginSignUpScreen = '/login-signup-screen';
const String loginScreen = '/login-screen';
const String signUpScreen = '/signup-screen';
const String pinLockScreen = '/pinlock-screen';
const String userFormScreen = '/userform-screen';
const String sendMoneyScreen = '/send-money-screen';
const String emailVerifiScreen = '/email-verifi-screen';
const String topUpScreen = '/top-up-screen';
const String forgetScreen = '/forget-screen';
const String changepassScreen = '/changepass-screen';
const String billScreen = '/bill-screen';
const String electryBillScreen = '/electry-screen';
const String greenUNScreen = '/green-screen';



List<GetPage> getPages = [
  GetPage(
      name: splash,
      page: () => SplashScreen()
  ),
  GetPage(
      name: onbording,
      page: () => Onbording()
  ),
  GetPage(
      name: homeScreen,
      page: () => BootomNavCon()
  ),
  GetPage(
      name: loginSignUpScreen,
      page: () => SignInSignUp()
  ),
  GetPage(
      name: loginScreen,
      page: () => SignIn()
  ),
  GetPage(
      name: signUpScreen,
      page: () => SignUp()
  ),
  GetPage(
      name: pinLockScreen,
      page: () => PinLock(),
  ),
  GetPage(
      name: userFormScreen,
      page: () => UserForm(),
  ),
   GetPage(
      name: sendMoneyScreen,
      page: () => SendMoney(),
  ),
  GetPage(
      name: emailVerifiScreen,
      page: () => VerificationCode(),
  ),
  GetPage(
      name: topUpScreen,
      page: () => TopUpScreen(),
  ),
  GetPage(
      name: forgetScreen,
      page: () => ForgetPass(),
  ),
  GetPage(
      name: changepassScreen,
      page: () => ChangePass(),
  ),
  GetPage(
      name: billScreen,
      page: () => BillScreen(),
  ),
  GetPage(
      name: electryBillScreen,
      page: () => ElectryBill(),
  ),
  GetPage(
      name: greenUNScreen,
      page: () => GreenUn(),
  ),






];