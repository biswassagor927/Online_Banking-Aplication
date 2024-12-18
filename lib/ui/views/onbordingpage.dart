import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/content_model.dart';
import '../route/route.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
   PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _exitDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure to close this app?"),
            content: Row(
              children: [
                ElevatedButton(
                  onPressed: ()=>Get.back(),
                  child: Text("No"),
                ),
                SizedBox(
                  width: 20.w,
                ),
                ElevatedButton(
                  onPressed: ()=>SystemNavigator.pop(),
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) {

        _exitDialog(context);
      }),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 208, 23, 190),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 16.w,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (() {
                                  _controller.jumpToPage(currentIndex - 1);
                                }),
                                child: Container(
                                  height: 45.75.h,
                                  width: 45.75.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/img/back.png'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(50.0),
                          child: Image.asset(
                            contents[i].image,
                            height: 300,
                          ),
                        ),
                        //image onbording
                        SizedBox(
                          height: 10.h,
                        ),
      
                        /*   //dot show
      
                        SizedBox(height: 20),
                        Text(
                          contents[i].discription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
      
                      */
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(25.sp),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  contents[i].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  contents[i].discription,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          contents.length,
                                          (index) => buildDot(index, context),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if(currentIndex==0){
                                          _controller.jumpToPage(currentIndex + 1);
                                        } else if(currentIndex==1){
                                          _controller.jumpToPage(currentIndex + 1);
      
                                        }else{
                                          Get.toNamed(loginSignUpScreen);
      
                                        }
                                        print(currentIndex);
      
                                        
                                      },
                                      child: Container(
                                        height: 65.h,
                                        width: 65.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/img/back2.png'),
                                              fit: BoxFit.fill),
                                        ),
                                      )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 6,
      width: currentIndex == index ? 18 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Color.fromARGB(255, 145, 213, 61) : Color.fromARGB(255, 33, 234, 137),
      ),
    );
  }
}
