import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chess_bot/gamechanger/PlayWithOnline.dart';
import 'package:chess_bot/wholeproject/Auth/login.dart';
import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Timer_page extends StatefulWidget {
  final String opid;
  final String table;
  final String prizepool;
  final String opname;
  final String opimage;
  final String position;



   Timer_page({Key key, this.opid, this.table, this.prizepool, this.opname, this.opimage, this.position, }) : super(key: key);

  @override
  _Timer_pageState createState() => _Timer_pageState();
}

class _Timer_pageState extends State<Timer_page> {
  final colorizeColors = [
    Colors.white,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  final colorizeTextStyle = const TextStyle(
    fontSize: 40.0,
  );
  @override
  void initState() {
    super.initState();
    Aman();
    // Timer(const Duration(seconds: 5), () => Get.off(const MainMenuView()));

  }
  Aman() async {


    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder:(context)=> PlayWithOnline(opid:widget.opid, table:widget.table,
          prizepool:widget.prizepool, opname:widget.opname,opimage:widget.opimage,position:widget.position)));
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return
      WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                // shadowColor: Colors.black,
                title: Text('Are you sure?', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
                content: Text('You are unable to go to lobby', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop;
        },
        child: Material(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.black,
          //   leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          //     Navigator.pop(context);
          //   },),
          // ),
          body: Container(
            width: width,
            // margin:  EdgeInsets.symmetric(vertical: 50),
            child:Image.asset("assets/images/timer.gif", fit: BoxFit.fitWidth,),
          ),
        ),
    ),
      );
  }
}
