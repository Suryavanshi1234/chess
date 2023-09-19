import 'dart:ui';


import 'package:chess_bot/wholeproject/constant.dart';
import 'package:chess_bot/wholeproject/home/TabWidgit/Deposit_Tab.dart';
import 'package:chess_bot/wholeproject/home/TabWidgit/Withdrawl_Tab.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History>with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    TabController _tabContrller = TabController(length: 2, vsync: this);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,)),
        backgroundColor: primaryColor,
      title: Text("History"),
      centerTitle: true,),
      body:  Column(
        children: [
          Container(
            // height: height*0.06,
            // width: width*0.9,
            color: Colors.black,
            child: TabBar(
              controller: _tabContrller,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), // Creates border
                  color: Colors.grey,),
              unselectedLabelColor:secondryColor,

              tabs: [
                Tab(
                  text: ("Deposit"),
                ),
                // Tab(
                //   text: ("ONCOMING"),
                // ),
                Tab(
                  text: ("Withdrawl"),
                ),
              ],
            ),
          ),
          Container(
            height: height*0.80,
            child:  TabBarView(controller: _tabContrller, children: [
              Deposit_History(),
              Withdrawl_History(),
            ]),
          )
        ],
      ),


    ));
  }
}
