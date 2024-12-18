import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/ui/styles/style.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/bottom_nav_contoler.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/top_up/check_pin.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/top_up/top_up.dart';

class AmountTopUpScreen extends StatelessWidget {
  

  var min = Get.put(StaticPageController());
  TextEditingController _amountController = TextEditingController();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    double totalBalance1 = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF6C6CC9),
        body: Padding(
          padding: EdgeInsets.only(top: 15.h, right: 15.w, left: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(TopUpScreen()),
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
                height: 40.h,
              ),
              TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _amountController,
                    maxLength: 5,
                    onChanged: (value) {
                      min.resetTimer();
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "this field can't be empty";
                      } else {
                        return null;
                      }
                    },
                  
                    decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        suffixIcon: IconButton(
                          onPressed: (){
                            
                            min.resetTimer();
                            int _amount = int.parse(_amountController.text);
                            if (_amountController.text.length == 0) {
                                Fluttertoast.showToast(msg: 'this field empty');
                              } else if(_amountController.text.length < 2){
                                Fluttertoast.showToast(msg: 'Minimum 10');
                                
                              }else if(totalBalance1 < _amount){
                                Fluttertoast.showToast(
                                  msg: 'insufficient balance');

                              } else{
                                box.write('amount', _amountController.text);
                                Get.to(CheckTopUpScreen());
                              }
                           },
                          icon: Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFF202244),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none),
                        hintStyle: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                  ),
              ),
                  SizedBox(
                height: 10.h,
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
                      totalBalance1 = totalBalance1 +
                          doc["tk"]; // make sure you create the variable sumTotal somewhere
                    });
                    return Column(
                      children: [
                        Text(
                          '${totalBalance1}',
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

              
            ],
          ),
        ),
      ),
    );
  }
}
