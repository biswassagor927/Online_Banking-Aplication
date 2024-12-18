import 'package:get/get.dart';
import 'package:online_mobile_banking_system/business_logics/neteork_controller.dart';

import 'business_logics/page_controller.dart';


class DependencyInjection {
  
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
    Get.put<StaticPageController>(StaticPageController(),permanent:true);
  }
}