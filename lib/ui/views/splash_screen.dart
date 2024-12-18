
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  final box = GetStorage();

  Future chooseScreen() async {
    var userId = box.read('uid');
    var _phonenum = box.read('phnum');
    print(userId);
    if(userId == null){
      Get.toNamed(onbording);
     // Get.toNamed(loginSignUpScreen);
    }else if(_phonenum==null){
      Get.toNamed(userFormScreen);
    }
    else {
      Get.toNamed(pinLockScreen);
      
      
    }
  }




  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),() => chooseScreen());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 21, 168),
        body: Stack(
          children: [
            Positioned(
              top: 47.h,
              right: 11.82.w,
              bottom: 31.5.h,
              child: Container(
                height: 733.5.h,
                width: 305.182.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/ellipse.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              top: 1.h,
              right: 13.w,
              child: Container(
                height: 131.h,
                width: 186.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/ellipserigt.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              top: 184.h,
              left: 2.w,
              right: 245.w,
              bottom: 449.43.h,
              child: Container(
                height: 129.065.h,
                width: 177.41.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/ellipsetop.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              top: 620.h,
              //left: 5.w,
              //right: 188.w,
              //bottom: 21.h,
              child: Container(
                height: 122.h,
                width: 182.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/ellipsemas.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              top: 294.h,
              right: 101.w,
              child: Container(
                height: 224.717.h,
                width: 172.w,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(30.r),
                  image: DecorationImage(
                    image: AssetImage('assets/logo/Firt Money.png.png'),
                    //fit: BoxFit.cover
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
