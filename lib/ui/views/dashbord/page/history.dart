import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/ui/widgets/account_button.dart';

import '../../../../business_logics/page_controller.dart';
import '../../../widgets/button.dart';
import '../bottom_nav_contoler.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  double totalBalance = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 211, 33, 164),
        body: Padding(
          padding: EdgeInsets.only(top: 15.h, right: 15.w, left: 15.w),
          child: Column(
            children: [
              Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Statistic',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/avtar.png'))),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Total Balance',
                style: TextStyle(
                    fontSize: 14.sp,
                    //fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 243, 243, 243)),
              ),
              
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('user-form-data')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('tk')
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  // if (snapshot.hasData && !snapshot.data!.exists) {
                  //   return Text("Document does not exist");
                  // }

                  if (querySnapshot.connectionState == ConnectionState.done) {
                    querySnapshot.data!.docs.forEach((doc) {
                      totalBalance = totalBalance +
                          doc["tk"]; // make sure you create the variable sumTotal somewhere
                    });
                    return Column(
                      children: [
                        Text(
                          '${totalBalance}',
                          style: TextStyle(
                              color: Color(0xFFA898F6),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }

                  return Text("loading");
                },
              ),
              SizedBox(
                height: 300.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Overview',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFA898F6)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 15.h, right: 15.w, left: 15.w, bottom: 15.h),
                    height: 130.h,
                    width: 150.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 38.h,
                          width: 38.w,
                          child: SvgPicture.asset(
                            'assets/svg/arroe_up.svg',
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(),
                        ),
                        Text(
                          'Income',
                          style: TextStyle(
                              fontSize: 14.sp,
                              //fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 243, 243, 243)),
                        ),
                        Text(
                          '\$150000.0000',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 243, 243, 243)),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3F3D9B),
                          Color(0xFF6C6CC9),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                
                  Container(
                    padding: EdgeInsets.only(
                        top: 15.h, right: 15.w, left: 15.w, bottom: 15.h),
                    height: 130.h,
                    width: 150.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 38.h,
                          width: 38.w,
                          child: SvgPicture.asset(
                            'assets/svg/arroe_up.svg',
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(),
                        ),
                        Text(
                          'Outcome',
                          style: TextStyle(
                              fontSize: 14.sp,
                              //fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 243, 243, 243)),
                        ),
                        Text(
                          '\$150000.0000',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 243, 243, 243)),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3F3D9B),
                          Color(0xFF6C6CC9),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
               ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
