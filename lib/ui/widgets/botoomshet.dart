import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_mobile_banking_system/business_logics/neteork_controller.dart';

class BootomSheep extends StatefulWidget {
  BootomSheep({Key? key}) : super(key: key);

  @override
  State<BootomSheep> createState() => _BootomSheepState();
}

class _BootomSheepState extends State<BootomSheep> {
  NetworkController net = Get.put(NetworkController());
  @override
  Widget build(BuildContext context) {
    return Container(child: showDialogBox(),);
  }

  showDialogBox() => showModalBottomSheet<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            // TextButton(
            //   onPressed: () async {
            //     Navigator.pop(context, 'Cancel');
            //     setState(() => net.isAlertSet.value = false);
            //     net.isDeviceConnected.value =
            //         await InternetConnectionChecker().hasConnection;
            //     if (!net.isDeviceConnected.value && net.isAlertSet.value == false) {
            //       showDialogBox();
            //       setState(() => net.isAlertSet.value = true);
            //     }
            //   },
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );
}

