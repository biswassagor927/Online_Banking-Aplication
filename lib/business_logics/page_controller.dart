import 'dart:async';

import 'package:get/get.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';

class StaticPageController extends GetxController {
  Timer? timer;
  RxInt _inactiveTimeInSeconds =
      500.obs; // Set the inactive time limit in seconds

  

  void resetTimer() {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(Duration(seconds: _inactiveTimeInSeconds.value), () {
      // Lock the app or perform any other action when inactive
      Get.toNamed(pinLockScreen);
      print('App locked due to inactivity.');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  // RxInt minutes = 2.obs;
  RxInt failedLoginAttemps = 0.obs;

  // Future StartTimer() async {
  //    Future.delayed(
  //       Duration(
  //         minutes: minutes.value,
  //         //seconds: 10,
  //       ), () {
  //     Get.offNamed(pinLockScreen);

  //     //var du = await min.minutes.value==null;
  //     //du.toString()==null? Get.offNamed(pinLockScreen) : null;

  //     minutes.value == 1 ? Get.offNamed(pinLockScreen) : null;
  //   });
  //   print('koto time ${minutes.value}');
  // }

  // void Reset() {
  //   minutes = 3.obs;
  //   update();
  // }

  void failedLoginIncriment() {
    failedLoginAttemps++;
    print(failedLoginAttemps);
  }
}
