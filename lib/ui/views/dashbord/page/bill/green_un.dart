import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/business_logics/billpay.dart';
import 'package:online_mobile_banking_system/business_logics/dropdown_con.dart';
import 'package:online_mobile_banking_system/business_logics/encrypt/encrypt_data.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/bill/bill.dart';
import 'package:online_mobile_banking_system/ui/widgets/button.dart';

import '../../../../../models/all_bill_model.dart';

class GreenUn extends StatefulWidget {
  @override
  State<GreenUn> createState() => _GreenUnState();
}

class _GreenUnState extends State<GreenUn> {
  TextEditingController _billnumController = TextEditingController();

  TextEditingController _studentIdController = TextEditingController();

  TextEditingController _amauntController = TextEditingController();

  TextEditingController _pinController = TextEditingController();

  RxBool passVisibility = false.obs;

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();
  DateTime dateTime = DateTime.now();
  var min = Get.put(StaticPageController());

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

  final _months = [
    "January 2024",
    "February 2024",
    "March 2024",
    "April 2024",
    "May 2024",
    "June 2024",
    "July 2024",
    "August 2024",
    "September 2024",
    "October 2024",
    "November 2024",
    "December 2024",
  ];

  @override
  Widget build(BuildContext context) {
    final DropdownController dropdownController = Get.put(DropdownController());

    double totalBalance1 = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 212, 35, 179),
        body: Padding(
          padding: EdgeInsets.only(
            top: 15.h,
            left: 10.w,
            right: 10.w,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(BillScreen()),
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
                    width: 100.w,
                  ),
                  Text(
                    'Education Free',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              //apbar
              SizedBox(
                height: 30.h,
              ),
              Card(
                  color: Color(0xFF161730),
                  child: ListTile(
                    title: Text(
                      'Green University Fee',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Tuition Fee',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        //fontWeight: FontWeight.w500
                      ),
                    ),
                    leading: Image.asset(
                      'assets/img/green.png',
                      height: 30.h,
                      width: 30.w,
                    ),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 50.h,
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF202244),
                        labelStyle: TextStyle(fontSize: 16.sp),
                        errorStyle: TextStyle(
                            color: Colors.redAccent, fontSize: 16.0.sp),
                        hintText: 'Bill Period',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 16.0.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                      ),
                      isEmpty: dropdownController.selectedIndex.value == null ||
                          dropdownController.selectedIndex.value == '',
                      child: DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton<int>(
                            elevation: 20,
                            value: dropdownController.selectedIndex.value == -1
                                ? null
                                : dropdownController.selectedIndex.value,
                            items: List.generate(_months.length, (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(
                                  _months[index],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.green,
                                  ),
                                ),
                              );
                            }),
                            onChanged: (int? newIndex) {
                              if (newIndex != null) {
                                dropdownController
                                    .updateSelectedIndex(newIndex);
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              TextFormField(
                onChanged: (value) {
                  min.resetTimer();
                },
                style: TextStyle(color: Colors.white),
                controller: _studentIdController,
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
                  hintText: 'Enter Student ID',
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
                height: 15.h,
              ),

              Button(
                  text: 'Proceed to Pay',
                  onAction: () {
                    min.resetTimer();
                    if (_studentIdController.text.length < 9) {
                      Fluttertoast.showToast(msg: 'invalid ID');
                    } else {
                      Get.bottomSheet(
                        Container(
                          height: 360.h,
                          padding: EdgeInsets.all(20.sp),
                          child: Column(
                            children: [
                              Text(
                                "Student ID: ${_studentIdController.text}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: _amauntController,
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
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection('tk')
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot>
                                        querySnapshot) {
                                  if (querySnapshot.hasError) {
                                    return Text("Something went wrong");
                                  }

                                  // if (snapshot.hasData && !snapshot.data!.exists) {
                                  //   return Text("Document does not exist");
                                  // }

                                  if (querySnapshot.connectionState ==
                                      ConnectionState.done) {
                                    querySnapshot.data!.docs.forEach((doc) {
                                      totalBalance1 = totalBalance1 +
                                          doc["tk"]; // make sure you create the variable sumTotal somewhere
                                    });
                                    return Column(
                                      children: [
                                        Text(
                                          'Blance: ${totalBalance1}',
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
                              Obx(
                                () => TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: _pinController,
                                  onChanged: (value) {
                                    min.resetTimer();
                                  },
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
                                          passVisibility.value =
                                              !passVisibility.value;
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                          size: 15.sp,
                                        )),
                                    filled: true,
                                    fillColor: Color(0xFF202244),
                                    border: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: BorderSide.none),
                                    hintStyle: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Button(
                                  text: 'Pay',
                                  onAction: () {
                                    min.resetTimer();
                                    final decrypted_pin = MyEncryptionDecryption
                                        .encrypter
                                        .decrypt64(_oldPin,
                                            iv: MyEncryptionDecryption.iv);
                                    min.resetTimer();
                                    print(_oldPin);
                                    int _pin = int.parse(_pinController.text);
                                    print(_pin);
                                    int _oldpinlast = int.parse(decrypted_pin);
                                    print(_oldpinlast);
                                    int amount =
                                        int.parse(_amauntController.text);
                                    if (_amauntController.text.length < 2) {
                                      Fluttertoast.showToast(msg: 'Minimum 10');
                                    } else if (totalBalance1 < amount) {
                                      Fluttertoast.showToast(
                                          msg: 'insufficient balance');
                                    } else if (_oldpinlast == _pin) {
                                      BillPayDb().billPayUn(
                                          _studentIdController.text,
                                          amount,
                                          dateTime, context);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'wrong Pin',
                                          textColor: Colors.red);
                                    }
                                  })
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF161730),
                              borderRadius: BorderRadius.circular(25.r)),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
