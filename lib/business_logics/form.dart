import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';

class UsersInfo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  sendFromDataToDB(
      String name, String phone, String pin,) async {
    try {
      CollectionReference _course =
          FirebaseFirestore.instance.collection('user-form-data');
      _course.doc(_auth.currentUser!.email).set({
        'name': name,
        'phone': phone,
        'pin': pin,
      }).whenComplete(
        () async {
          
          box.write('phnum', phone);
          Fluttertoast.showToast(msg: 'Added Successfully');
          Get.toNamed(pinLockScreen);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'error: $e');
    }
  }
}
