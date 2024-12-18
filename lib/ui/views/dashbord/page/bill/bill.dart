import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/business_logics/page_controller.dart';
import 'package:online_mobile_banking_system/models/all_bill_model.dart';
import 'package:online_mobile_banking_system/models/bill_type_bodel.dart';

import '../../bottom_nav_contoler.dart';

class BillScreen extends StatelessWidget {
  TextEditingController _search = TextEditingController();
  var min = Get.put(StaticPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 220, 42, 202),
        body: Padding(
          padding: EdgeInsets.only(
            top: 15.h,
            left: 10.w,
            right: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Bill',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              //appbar
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _search,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "this field can't be empty";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Enter Biller Name',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: Container(
                    height: 20.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3F3D9B),
                          Color(0xFF6C6CC9),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Filter',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/svg/serch_filter.svg',
                            fit: BoxFit.cover,
                            width: 16.w,
                            height: 16.h,
                          ),
                        ),
                      ],
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
              //Serch bar
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Bill Type',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA898F6),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 200.h,
                width: double.infinity,
                child: GridView.builder(
                    itemCount: billtype.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 20.sp,
                      crossAxisSpacing: 0,
                      //childAspectRatio:1 ,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF202244),
                              borderRadius: BorderRadius.circular(15.r)
                            ),
                            height: 60.h,
                            width: 65.w,
                            child: SvgPicture.asset(
                              billtype[index].icon,
                              fit: BoxFit.none,
                              height: 30.h,
                              width: 20.w,
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          Text(billtype[index].title,style: TextStyle(
                            color: Colors.white
                          ),)
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'All institutions',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA898F6),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allbill.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        min.resetTimer();
                        Get.toNamed(allbill[index].rute);
                      },
                      child: Card(
                        color: Color(0xFF161730),
                        child: ListTile(
                          title: Text(allbill[index].title,style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500
                          ),),
                          subtitle: Text(allbill[index].discription,style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.w500
                          ),),
                          leading: Image.asset(allbill[index].image,height: 30.h,width: 30.w,),
                                      
                        )
                        ),
                    );
                  })
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
