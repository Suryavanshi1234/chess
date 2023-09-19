import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chess_bot/wholeproject/Dashboard/More.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:chess_bot/wholeproject/constwidget/sliderwidget.dart';

//
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;







class Play_Friend_Tablepage extends StatefulWidget {
  final String type;
  const Play_Friend_Tablepage({ this.type}) ;

  @override
  State<Play_Friend_Tablepage> createState() => _Play_Friend_TablepageState();
}

class _Play_Friend_TablepageState extends State<Play_Friend_Tablepage> with TickerProviderStateMixin{
  TextEditingController field = TextEditingController();
  String pasteValue='';
  void initState() {
    // viewprofile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    TabController _tabContrller = TabController(length: 2, vsync: this);
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
            BannerWidget(type:widget.type)

          ],
        ),
      ),
    );
  }
  // var map;
  // viewprofile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userid=prefs.getString("userId");
  //   final response = await http.get(
  //     Uri.parse(Apiconst.Level+"id=$userid"),
  //   );
  //   var data = jsonDecode(response.body);
  //   print(data);
  //   print("mmmmmmmmmmmm");
  //   if (data["error"] == '200') {
  //     setState(() {
  //       map =data['data'];
  //
  //     });
  //   }
  // }
}
