import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';

class BillPayDb{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void billPay(var number, int amount,var date) async {
    try {
      CollectionReference _course =
          FirebaseFirestore.instance.collection('user-form-data');

          _course.doc(_auth.currentUser!.email).collection('transaction_out').doc().set({
        'tk': amount,
        'name': number,
        'date': date,
        'sendtype': 'Bill'
      }).whenComplete(
        () async {},
      );

      _course.doc(_auth.currentUser!.email).collection('tk').doc().set({
        'tk': -amount,
        'name': number,
        'date': date,
      }).whenComplete(
        () async {
          Fluttertoast.showToast(msg: 'Payment Successful');
          Get.toNamed(homeScreen);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'error: $e');
    }

  }

  void billPayUn(var number, int amount,var date, context) async {
    try {
      CollectionReference _course =
          FirebaseFirestore.instance.collection('user-form-data');

          _course.doc(_auth.currentUser!.email).collection('transaction_out').doc().set({
        'tk': amount,
        'name': number,
        'date': date,
        'sendtype': 'Education Free'
      }).whenComplete(
        () async {},
      );

      _course.doc(_auth.currentUser!.email).collection('tk').doc().set({
        'tk': -amount,
        'name': number,
        'date': date,
      }).whenComplete(
        () async {
          //Fluttertoast.showToast(msg: 'Payment Successful');
          AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.success,
                          showCloseIcon: true,
                          title: 'Succes',
                          desc: 'Payment Successful',
                          btnOkOnPress: () {
                            debugPrint('OnClcik');
                            Future.delayed(const Duration(seconds: 1), () {
                                  //Navigator.pop(context);
                                  Get.toNamed(homeScreen);
                                });
                          },
                          btnOkIcon: Icons.check_circle,
                          onDismissCallback: (type) {
                            debugPrint('Dialog Dissmiss from callback $type');
                          },
                        ).show();
          //Get.toNamed(homeScreen);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'error: $e');
    }

  }
  
}