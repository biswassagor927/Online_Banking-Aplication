import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/encrypt/encrypt_data.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/business_logics/topup_db.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/bottom_nav_contoler.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/top_up/amount_top_up.dart';
import 'package:online_mobile_banking_system/ui/widgets/button.dart';

class CheckTopUpScreen extends StatefulWidget {
  @override
  State<CheckTopUpScreen> createState() => _CheckTopUpScreenState();
}

class _CheckTopUpScreenState extends State<CheckTopUpScreen> {
  TextEditingController _pinController = TextEditingController();

  var min = Get.put(StaticPageController());

  final box = GetStorage();
  DateTime dateTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _oldPin;

  @override
  void initState() {
    try {
      var userId = box.read('uid');

      FirebaseFirestore.instance
          .collection('user-form-data')
          .doc(_auth.currentUser!.email)
          .get()
          .then((value) {
        setState(() {
          _oldPin = value.data()!['pin'];
        });
      });
    } catch (err) {
      print(err.runtimeType);
    }

    super.initState();
  }

  //final _number =  box.read('email');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 206, 58, 174),
        body: Padding(
          padding: EdgeInsets.only(top: 15.h, right: 15.w, left: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(AmountTopUpScreen()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Send To:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    box.read('phonenumtopup'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Amount:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    box.read('amount'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _pinController,
                  onChanged: (value) {
                    min.resetTimer();
                  },
                  maxLength: 5,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    } else if (val.length < 5) {
                      return 'Minimum 5 Digit Pin';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Pin',
                    suffixIcon: IconButton(
                      onPressed: () {
                        final decrypted_pin = MyEncryptionDecryption.encrypter.decrypt64(_oldPin, iv: MyEncryptionDecryption.iv);
                        min.resetTimer();
                        print(_oldPin);
                        int _pin = int.parse(_pinController.text);
                        print(_pin);
                        int _oldpinlast = int.parse(decrypted_pin);
                        print(_oldpinlast);

                        int phone = int.parse(box.read('phonenumtopup'));
                        int amount = int.parse(box.read('amount'));

                        if (_pinController.text.length < 5) {
                          Fluttertoast.showToast(msg: 'Minimum 5 Digit Pin');
                        } else if (_oldpinlast == _pin) {
                          Get.defaultDialog(
                              title: 'Mobile Recharge',
                              middleText: box.read('amount'),
                              confirm: Button(text: 'Confirm', onAction: () {
                                min.resetTimer();
                                TopUpDb().topUp(phone, amount, dateTime);
                              }),
                              cancel: Button(
                                  text: 'Cancel',
                                  onAction: () {
                                    Get.back();
                                    min.resetTimer();
                                  }));
                        } else {
                          Fluttertoast.showToast(
                              msg: 'wrong Pin', textColor: Colors.red);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
