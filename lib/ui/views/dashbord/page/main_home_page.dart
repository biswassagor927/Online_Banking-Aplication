import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/tansaction/transaction.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/transfer/transfer.dart';
import 'package:online_mobile_banking_system/ui/views/send_money.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StaticPageController min = Get.put(StaticPageController());

  int currentIndex = 0;
  String? _name;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late ScrollController _controller;

  // late StreamSubscription subscription;
  // bool isDeviceConnected = false;
  // bool isAlertSet = false;

  @override
  void initState() {
    //getConnectivity();
    _controller = ScrollController(initialScrollOffset: 0);
    try {
      FirebaseFirestore.instance
          .collection('user-form-data')
          .doc(_auth.currentUser!.email)
          .get()
          .then((value) {
        setState(() {
          _name = value.data()!['name'];
        });
      });
    } catch (err) {
      print(err.runtimeType);
    }
    super.initState();
  }

  // getConnectivity() =>
  //     subscription = Connectivity().onConnectivityChanged.listen(
  //       (ConnectivityResult result) async {
  //         isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //         if (!isDeviceConnected && isAlertSet == false) {
  //           showDialogBox();
  //           setState(() => isAlertSet = true);
  //         }
  //       },
  //     );

  @override
  void dispose() {
    //subscription.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 48, 224),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 15.h,
            left: 10.w,
            right: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Center(
                            child: Text(
                          'OP',
                          style: TextStyle(color: Colors.white),
                        )),
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.r),
                          color: Color.fromARGB(255, 49, 145, 158),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Hello, ${_name}!',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            print('click');
                          },
                          icon: Icon(
                            Icons.notification_important_outlined,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),

              ///Notification Account Name
              SizedBox(
                height: 15.h,
              ),
              Text(
                'My Card',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              SingleChildScrollView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(6.sp),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 72, 151, 194),
                                Color.fromARGB(195, 29, 103, 113),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15.sp)),
                        height: 170.h,
                        width: 300.w,
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "VISA",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.linear_scale_sharp,
                                        color: const Color.fromARGB(255, 241, 243, 241),
                                      ))
                                ],
                              ),
                              Text(
                                'CARD NUMBER',
                                style: TextStyle(
                                    fontSize: 9.sp, color: Color(0xFFFEFEFE)),
                              ),
                              Text(
                                '**** **** **** *379',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'CARD HOLDER NAME',
                                    style: TextStyle(
                                        fontSize: 9.sp, color: Colors.white),
                                  ),
                                  Text(
                                    'EXPIRE DATE',
                                    style: TextStyle(
                                        fontSize: 9.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Precious Ogar',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '02/25',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 48, 226, 223),
                                Color.fromARGB(255, 61, 150, 156),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        height: 170.h,
                        width: 300.w,
                        child: Padding(
                          padding: EdgeInsets.all(20.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'VISA',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.linear_scale_sharp,
                                        color: Colors.green,
                                      ))
                                ],
                              ),
                              Text(
                                'CARD NUMBER',
                                style: TextStyle(
                                    fontSize: 9.sp, color: Color(0xFFFEFEFE)),
                              ),
                              Text(
                                '**** **** **** *379',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'CARD HOLDER NAME',
                                    style: TextStyle(
                                        fontSize: 9.sp, color: Colors.white),
                                  ),
                                  Text(
                                    'EXPIRE DATE',
                                    style: TextStyle(
                                        fontSize: 9.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Precious Ogar',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '02/25',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///card

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              ///dot indicator
              Text(
                'Featured',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 254, 254, 255)),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      min.resetTimer();
                      Get.toNamed(topUpScreen);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          child: SvgPicture.asset(
                            'assets/svg/dollar.svg',
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Top Up',
                          style: TextStyle(
                              fontSize: 12.sp,
                              //fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      min.resetTimer();
                      
                      Get.toNamed(billScreen);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          child: SvgPicture.asset(
                            'assets/svg/bill.svg',
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Bill',
                          style: TextStyle(
                              fontSize: 12.sp,
                              //fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      min.resetTimer();
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          child: SvgPicture.asset(
                            'assets/svg/transfer.svg',
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Transfer',
                          style: TextStyle(
                              fontSize: 12.sp,
                              //fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ],
                    ),
                  ),
                  
                  InkWell(
                    onTap: () {
                      min.resetTimer();
                      Get.to(SendMoney());
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          child: Icon(
                            Icons.send_rounded,
                            color: Color(0xFFA898F6),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 226, 235, 236),
                              borderRadius: BorderRadius.circular(5.r)),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Send Money',
                          style: TextStyle(
                              fontSize: 12.sp,
                              //fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),

              ///history
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  height: 350.h,
                  width: 400.w,
                  padding: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
                 // child: PaymantPage(),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 6,
      width: currentIndex == index ? 18 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Color.fromARGB(255, 136, 155, 61) : Color.fromARGB(255, 108, 201, 201),
      ),
    );
  }
}
