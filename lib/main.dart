import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/encrypt/encrypt_data.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/bill/electry_bill.dart';
import 'package:online_mobile_banking_system/ui/views/splash_screen.dart';
import 'const/app_strings.dart';
import 'dependency_injection.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  DependencyInjection.init();
  MyEncryptionDecryption.key;
  MyEncryptionDecryption.iv;
  MyEncryptionDecryption.encrypter;
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    name: "FASTMONEY",
    options: FirebaseOptions(
        apiKey: "AIzaSyDiUPthpYmcHFtpd7XIXBnrLztytx7YglE",
        appId: "1:232985191765:android:127123ab99b8860c46fbdc",
        messagingSenderId: "232985191765",
        projectId: "online-mobile-banking-system"),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MyApp();
          }
          return CircularProgressIndicator();
        });
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.appName,
          //translations: AppLanguages(),
          //locale: Locale('en', 'US'),
          //fallbackLocale: Locale('en', 'US'),
          //theme: AppTheme().lightTheme(context),
          //darkTheme: AppTheme().darkTheme(context),
          //themeMode: ThemeMode.light,
          
          initialRoute: splash,
          getPages: getPages,
          home: SplashScreen(),
           //home: ElectryBill(),
        );
      },
    );
  }
}
