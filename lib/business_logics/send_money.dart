import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';

class SendMoneyDB {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  sendMonyToDB(String email, int amount, var date) async {
    try {
      CollectionReference _course =
          FirebaseFirestore.instance.collection('user-form-data');

      //  var harname = await  _course.doc(email).get().asStream();
      //  print(harname);

      var harname = await FirebaseFirestore.instance
          .collection('user-form-data')
          .doc(email)
          .get()
          .then((value) {
        return value['name'];
      });

      var myname = await FirebaseFirestore.instance
          .collection('user-form-data')
          .doc(_auth.currentUser!.email)
          .get()
          .then((value) {
        return value['name'];
      });

      _course.doc(email).collection('tk').doc().set({
        'tk': amount,
        'name': myname,
        'date': date,
      }).whenComplete(
        () async {},
      );
      //new in
      _course.doc(email).collection('transaction_in').doc().set({
        'tk': amount,
        'name': myname,
        'date': date,
      }).whenComplete(
        () async {},
      );
      //
      //new out
      _course.doc(_auth.currentUser!.email).collection('transaction_out').doc().set({
        'tk': amount,
        'name': harname,
        'date': date,
        'sendtype': 'Send Money'
      }).whenComplete(
        () async {},
      );
      //

      _course.doc(_auth.currentUser!.email).collection('tk').doc().set({
        'tk': -amount,
        'name': harname,
        'date': date,
      }).whenComplete(
        () async {
          Fluttertoast.showToast(msg: 'Send Successfully');
          Get.toNamed(homeScreen);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'error: $e');
    }
  }
}
