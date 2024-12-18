import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/encrypt/encrypt_data.dart';
import 'package:online_mobile_banking_system/business_logics/form.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:online_mobile_banking_system/ui/styles/style.dart';
import 'package:online_mobile_banking_system/ui/widgets/button.dart';
//import 'package:encrypt/encrypt.dart' as encrypt;

class UserForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _numController = TextEditingController();
  TextEditingController _pinController = TextEditingController();

  TextEditingController _numCountry = TextEditingController(
    text: '+88',
  );

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 25, 128),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, right: 15.w, left: 15.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(loginSignUpScreen),
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
                      'Let’s Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Create\n Account!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    } else {
                      return null;
                    }
                  },
                  controller: _nameController,
                  style: AppStyle().myTextForm,
                  decoration: AppStyle().textFieldDecoration(
                    'Full Name',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90.h,
                      width: 80.w,
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
                      width: 260.w,
                      height: 90.h,
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
                        controller: _numController,
                        maxLength: 11,
                        style: AppStyle().myTextForm,
                        decoration: AppStyle().textFieldDecoration(
                          'Enter Your Number',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  controller: _pinController,
                  style: AppStyle().myTextForm,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "this field can't be empty";
                    } else if (val.length < 5) {
                      return "Minimum 5 Digit Pin";
                    } else {
                      return null;
                    }
                  },
                  decoration: AppStyle().textFieldDecoration(
                      'Enter 5 Digit Pin', Icons.visibility_off_outlined),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Button(
                    text: "Submit",
                    onAction: () {
                      final encrypted = MyEncryptionDecryption.encrypter.encrypt(
                      _pinController.text,
                      iv: MyEncryptionDecryption.iv);
                      print(encrypted.base64);
                      

                      String a = '${_numCountry.text}';
                      String b = '${_numController.text}';
                      var _numbar = (a + b);
                      print(_numbar);
                      var _phonenum = box.write('phnum', _numbar);
                      UsersInfo().sendFromDataToDB(
                          _nameController.text, _numbar, encrypted.base64);
                    }
                    ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
