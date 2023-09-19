import 'package:carousel_slider/carousel_slider.dart';
import 'package:chess_bot/wholeproject/Dashboard/More.dart';
import 'package:chess_bot/wholeproject/constwidget/onlline_slider.dart';
import 'package:chess_bot/wholeproject/constwidget/unlimited_slider.dart';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';





class Online_Table_Page extends StatefulWidget {
  final String type;
   Online_Table_Page({ this.type}) ;

  @override
  State<Online_Table_Page> createState() => _Online_Table_PageState();
}

class _Online_Table_PageState extends State<Online_Table_Page> {
@override
  void dispose() {
  // Online_Slider();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc19272),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Details()));
              },
              icon: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/BackGround.png"),fit: BoxFit.fill,)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Online_Slider(type:widget.type)

          ],
        ),
      ),
    );
  }
}
