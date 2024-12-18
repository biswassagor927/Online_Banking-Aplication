import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/business_logics/encrypt/encrypt_data.dart';
import 'package:online_mobile_banking_system/ui/widgets/button.dart';

class Transfer extends StatefulWidget {
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool passVisibility = false.obs;

  TextEditingController _pinController = TextEditingController();

  late var _oldPin;

  @override
  void initState() {
    try {
      FirebaseFirestore.instance
          .collection('user-form-data')
          .doc('1')
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _pinController,
                maxLength: 5,
                obscureText: !passVisibility.value,
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
                        passVisibility.value = !passVisibility.value;
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 15.sp,
                      )),
                  filled: true,
                  fillColor: Color.fromARGB(255, 192, 239, 51),
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
              height: 20.h,
            ),
            Button(
                text: 'Submit',
                onAction: () {
                  final encrypted = MyEncryptionDecryption.encrypter.encrypt(
                      _pinController.text,
                      iv: MyEncryptionDecryption.iv);
                  print(encrypted.base64);
                  CollectionReference _course =
                      FirebaseFirestore.instance.collection('user-form-data');
                  _course.doc('1').set({
                    'pin': encrypted.base64,
                  }).whenComplete(
                    () async {
                      Fluttertoast.showToast(msg: 'Added Successfully');
                    },
                  );
                }),
            Text(
              _oldPin,
              style: TextStyle(fontSize: 22, color: Colors.red),
            ),
            Button(
                text: 'ondis',
                onAction: () async {
                 

                   final decrypted = MyEncryptionDecryption.encrypter.decrypt64(_oldPin, iv: MyEncryptionDecryption.iv);
                   print(decrypted);
                })
          ],
        ),
      ),
    );
  }
}
