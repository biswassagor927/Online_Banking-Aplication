import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/const/app_colors.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';
import 'package:online_mobile_banking_system/ui/widgets/account_button.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   String? _name;
   final box = GetStorage();

   void logOut(context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Are You Sure To Logout?"),
          content: Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then(
                        (value) => Fluttertoast.showToast(
                        msg: "Logout Successful"),
                  );
                  await box.remove('uid');
                  await box.remove('phnum');
                  Get.toNamed(loginSignUpScreen);
                  Future.delayed(Duration(seconds: 2,),(){
                    SystemNavigator.pop();

                  });
                },
                child: Text("Yes"),
              ),
              SizedBox(
                width: 10.w,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("No"),
              ),
            ],
          ),
        ));
  }

   @override
  void initState() {
    
    try {
      FirebaseFirestore.instance
          .collection('user-form-data')
          .doc(_auth.currentUser!.email)
          .get()
          .then((value) {
            
        setState(() {
          _name = value.data()!['name'];
        });
      });
    } catch (err) {
      print(err.runtimeType);
    }

    super.initState();
  }

  @override
  void dispose() {
    _name;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.only(top: 15.h, right: 15.w, left: 15.w),
          child: Column(
            children: [
              Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 110.h,
                width: 110.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/avtar.png'))),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                '${_name}',
                style: TextStyle(
                    color: Color(0xFFA898F6),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${_auth.currentUser!.email}',
                style: TextStyle(
                    fontSize: 14.sp,
                    //fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 243, 243, 243)),
              ),
              SizedBox(
                height: 30.h,
              ),
              AccountButton(
                  text: 'Password',
                  onAction: () {
                    Get.toNamed(changepassScreen);
                  },
                  icon: Icons.key_sharp,
                  iconlast: Icons.arrow_right),
                  SizedBox(
                height: 15.h,
              ),
                  AccountButton(
                  text: 'Touch ID',
                  onAction: () {},
                  icon: Icons.fingerprint,
                  iconlast: Icons.arrow_right),
                  SizedBox(
                height: 15.h,
              ),
                  AccountButton(
                  text: 'Language',
                  onAction: () {},
                  icon: Icons.language_outlined,
                  iconlast: Icons.arrow_right),
                  SizedBox(
                height: 15.h,
              ),
                  AccountButton(
                  text: 'App Information',
                  onAction: () {},
                  icon: Icons.info_outline,
                  iconlast: Icons.arrow_right),
                  SizedBox(
                height: 15.h,
              ),
                  AccountButton(
                  text: 'Customer Care',
                  onAction: () {},
                  icon: Icons.headphones,
                  iconlast: Icons.arrow_right),
                  SizedBox(
                height: 15.h,
              ),
              AccountButton(
                  text: 'logOut',
                  onAction: () => logOut(context),
                  icon: Icons.logout_outlined,
                  iconlast: Icons.arrow_right),

            ],
          ),
        ),
      ),
    );
  }
}
