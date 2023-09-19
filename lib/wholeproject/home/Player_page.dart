import 'dart:convert';

import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;


class Player_page extends StatefulWidget {
  const Player_page({Key key}) : super(key: key);

  @override
  State<Player_page> createState() => _Player_pageState();
}

class _Player_pageState extends State<Player_page> {
  void initState() {
    viewprofile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      body: Container(height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg2.png",),fit: BoxFit.fill,)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: CircleAvatar(radius: 70,backgroundColor: Colors.white,
                child: Image.asset("assets/images/ChessLogo.png"),),
            ),
            SizedBox(height: 100,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(alignment: Alignment.center,
                      height: height*0.16,
                      width: width*0.29,
                      decoration: BoxDecoration(
                          image: DecorationImage(filterQuality: FilterQuality.low,
                            image: AssetImage("assets/images/Frame.png"),fit: BoxFit.fill,)),
                      child: map["image"]==null?"":
                      Container(
                        height: height*0.12,
                        width: width*0.22,
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage( Apiconst.Imageurl+map["image"]))
                            ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: height*0.02,
                      width: width*0.3,
                      decoration: BoxDecoration(borderRadius:
                      BorderRadius.all(Radius.circular(30)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/Name_frame.png"),fit: BoxFit.fill,)),
                    )
                  ],
                ),
                CircleAvatar(radius: 20,
                  backgroundColor: primaryColor,
                  child: Text("VS")),
                Column(
                  children: [
                    Container(alignment:Alignment.center,
                      height: height*0.16,
                      width: width*0.29,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Frame.png"),fit: BoxFit.fill,)),
                      child:  Container(
                        height: height*0.12,
                        width: width*0.22,
                        decoration: BoxDecoration(borderRadius:
                        BorderRadius.all(Radius.circular(20)),color: Colors.yellow
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: height*0.02,
                      width: width*0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Name_frame.png"),fit: BoxFit.fill,)),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 70,),
            Container(alignment: Alignment.center,
              height: height*0.07,
              width: width*0.7,
              decoration: BoxDecoration(borderRadius:
              BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/Name_frame.png"),fit: BoxFit.fill,)),
              child: Text("Searching For Player... ",
                style: TextStyle(
                    fontSize: 20
                    ,color: Colors.white,
                    fontWeight:FontWeight.w900,),),
            ),


          ],
        ),
      ),
    ));
  }
  var map;
  viewprofile() async {
    print("😂😂😂😂😂");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.get(
      Uri.parse(Apiconst.profile+"id=$userid"),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data["error"] == '200') {
      setState(() {
        map =data['data'];

      });
    }
  }
}
