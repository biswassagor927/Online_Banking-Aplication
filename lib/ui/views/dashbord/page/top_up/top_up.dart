import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/ui/styles/style.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/bottom_nav_contoler.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/top_up/amount_top_up.dart';

class TopUpScreen extends StatelessWidget {
  TextEditingController _numController = TextEditingController();
  TextEditingController _numCountry = TextEditingController(
    text: '+88',
  );

  var min = Get.put(StaticPageController());
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 233, 12, 185),
        body: Padding(
          padding: EdgeInsets.only(top: 15.h, right: 15.w, left: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(BootomNavCon()),
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/back.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    'Mobile Recharge',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      height: 90.h,
                      child: TextFormField(
                        controller: _numCountry,
                        style: AppStyle().myTextForm,
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                          //fillColor: Color(0xFF202244),

                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    Container(
                      height: 90.h,
                      width: 260.w,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "this field can't be empty";
                          } else if (val.length < 11) {
                            return "Minimum 11 Digit Number";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _numController,
                        onChanged: (value) {
                          min.resetTimer();
                        },
                        maxLength: 11,
                        style: AppStyle().myTextForm,
                        decoration: InputDecoration(
                          hintText: 'enter number(ex:01*********)',
                          suffixIcon: IconButton(
                            onPressed: () {
                              String a = '${_numCountry.text}';
                              String b = '${_numController.text}';
                              var _numbar = (a + b);

                              min.resetTimer();
                              if (_numController.text.length == 0) {
                                Fluttertoast.showToast(msg: 'this field empty');
                              } else if (_numController.text.length >= 11) {
                                box.write('phonenumtopup', _numbar);
                                Get.bottomSheet(
                                  Container(
                                    height: 300.h,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10.sp),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Choose Oparetor',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                min.resetTimer();
                                                Get.to(AmountTopUpScreen());
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/img/gp.png'),
                                                        fit: BoxFit.fill),
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r)),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                min.resetTimer();
                                                Get.to(AmountTopUpScreen());
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/img/airtel.png',),
                                                        fit: BoxFit.cover),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r)),
                                              ),
                                            ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                min.resetTimer();
                                                Get.to(AmountTopUpScreen());
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/img/bl.jpeg'),
                                                        fit: BoxFit.cover),
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r)),
                                              ),
                                            ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r)),
                                            ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 224, 39, 197),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
