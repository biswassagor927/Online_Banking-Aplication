import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/encrypt/encrypt_data.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/acccount.dart';

import '../../styles/style.dart';
import '../../widgets/button.dart';

class ChangePass extends StatefulWidget {
  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController _pinController = TextEditingController();

  TextEditingController _passController = TextEditingController();

  TextEditingController _conPassController = TextEditingController();

  RxBool passVisibility = false.obs;
  RxBool pinVisibility = false.obs;

  final _formKey = GlobalKey<FormState>();

  final box = GetStorage();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 23, 160),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, right: 15.w, left: 15.w),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(AccountPage());
                    },
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
                    'Change Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Enter a new password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              Obx(
                () => TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _pinController,
                  maxLength: 5,
                  obscureText: !pinVisibility.value,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    } else if (val.length < 5) {
                      return "Minimum 5 Digit Pin";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Pin',
                    suffixIcon: IconButton(
                        onPressed: () {
                          pinVisibility.value = !pinVisibility.value;
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 15.sp,
                        )),
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
              SizedBox(
                height: 15.h,
              ),
              Obx(
                () => TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passController,
                  obscureText: !passVisibility.value,
                  maxLength: 12,
                  style: AppStyle().myTextForm,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    } else if (val.length < 8) {
                      return "Minimum 8 Digit Password";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'New Minimum 8 dight password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          passVisibility.value = !passVisibility.value;
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 15.sp,
                        )),
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
              SizedBox(
                height: 15.h,
              ),
              Obx(
                () => TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _conPassController,
                  obscureText: !passVisibility.value,
                  maxLength: 12,
                  style: AppStyle().myTextForm,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    } else if (val.length < 8) {
                      return "Minimum 8 Digit Password";
                    } else if ((_passController.text ==
                        _conPassController.text)) {
                      return "Password match";
                    } else {
                      return "Password not match";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm Minimum 8 dight password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          passVisibility.value = !passVisibility.value;
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 15.sp,
                        )),
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
              SizedBox(
                height: 30.h,
              ),
              Button(
                text: 'Confirm',
                onAction: () {
                  int _pin = int.parse(_pinController.text);
                  print(_pin);
                  final decrypted_pin = MyEncryptionDecryption.encrypter
                      .decrypt64(_oldPin, iv: MyEncryptionDecryption.iv);
                  int _oldpinlast = int.parse(decrypted_pin);

                  if (_passController.text.length < 8) {
                    Fluttertoast.showToast(msg: 'minimum 8 digit');
                  } else if (_passController.text == _conPassController.text &&
                      _oldpinlast == _pin) {
                    //enter fu
                    try {
                      FirebaseAuth.instance.currentUser!
                          .updatePassword(_conPassController.text)
                          .whenComplete(() {
                        Get.toNamed(homeScreen);
                        Fluttertoast.showToast(
                            msg: 'Password changed successfully');
                      });
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'Password $e');
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'pin not matching');
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
