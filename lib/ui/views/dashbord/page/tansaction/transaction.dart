import 'package:flutter/material.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/tansaction/in.dart';
import 'package:online_mobile_banking_system/ui/views/dashbord/page/tansaction/out.dart';

import '../../../../../const/app_colors.dart';

class TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        
        child: Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 249, 250, 249),
            bottom: TabBar(
              tabs: [
                Tab(text: 'In',),
                Tab(text: 'Out',),
                
              ],
            ),
            title: Text('Transaction'),
          ),
          body: TabBarView(
            children: [
              In(),
              Out()
              
              
            ],
          ),
        ),
      );

    
  }
}
