import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/business_logics/email_vali.dart';
import 'package:online_mobile_banking_system/business_logics/encrypt/encrypt_data.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/business_logics/send_money.dart';
import 'package:online_mobile_banking_system/ui/styles/style.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/bottom_nav_contoler.dart';
import 'package:online_mobile_banking_system/ui/widgets/button.dart';

class SendMoney extends StatefulWidget {
  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final _formKey = GlobalKey<FormState>();
  var min = Get.put(StaticPageController());
  
  DateTime dateTime = DateTime.now();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _pinController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _totalTkController = TextEditingController();

  late String _oldPin;

  @override
  void initState() {
    
    try {
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
    double totalBalance1 = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 37, 176),
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
                    'Send Money',
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
              SizedBox(
                height: 10.h,
              ),

              ///Appbar
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _emailController,
                        onChanged: ((value) => min.resetTimer()),
                        maxLength: 30,
                        validator: (value) => EmailVal().validateEmail(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppStyle().textFieldDecoration(
                          'Enter email',
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _totalTkController,
                        onChanged: ((value) => min.resetTimer()),
                        maxLength: 5,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "this field can't be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: AppStyle().textFieldDecoration(
                          'Enter Amount',
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _pinController,
                        maxLength: 5,
                        onChanged: ((value) => min.resetTimer()),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "this field can't be empty";
                          } else if (val.length < 5) {
                            return "Minimum 5 Digit Pin";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: AppStyle().textFieldDecoration(
                            'Enter Pin', Icons.visibility_off_outlined),
                      ),
                      Button(
                          text: "Send",
                          onAction: () {
                            final decrypted_pin = MyEncryptionDecryption.encrypter.decrypt64(_oldPin, iv: MyEncryptionDecryption.iv);
                            int _amount = int.parse(_totalTkController.text);
                            int _pin = int.parse(_pinController.text);
                            print(_pin);
                            int _oldpinlast = int.parse(decrypted_pin);
                            print(_oldpinlast);

                            if (totalBalance1 < _amount) {
                              Fluttertoast.showToast(
                                  msg: 'insufficient balance');
                            } else if (_oldpinlast == _pin) {
                              SendMoneyDB()
                                  .sendMonyToDB(_emailController.text, _amount, dateTime);
                            } else {
                              Fluttertoast.showToast(msg: 'Invalid pin',textColor: Colors.red);
                            }
                          }),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
