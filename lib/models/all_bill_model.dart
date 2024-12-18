import 'package:get/get.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/bill/green_un.dart';

import '../ui/route/route.dart';

class AllBillModel {
  String image;
  String title;
  String discription;
  dynamic rute;


  AllBillModel({required this.image, required this.title, required this.discription, this.rute});
}

List<AllBillModel> allbill = [
  AllBillModel(
      title: 'BPDB',
      image: 'assets/img/ctbank.png',
      discription: "Electricity Fee",
      rute: electryBillScreen
  ),
  AllBillModel(
      title: 'NID Service',
      image: 'assets/img/nidlogo.png',
      discription: "Govt Fee"
  ),
  AllBillModel(
      title: 'Green University Fee',
      image: 'assets/img/green.png',
      discription: "Tuition Fee",
      rute: greenUNScreen
  ),
  AllBillModel(
      title: 'City Bank Credit Card  Bill',
      image: 'assets/img/ctbank.png',
      discription: "Credit Card Fee"
  ),
  
  
];