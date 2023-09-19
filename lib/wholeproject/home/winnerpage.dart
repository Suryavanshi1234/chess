import 'dart:convert';

import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_board/flutter_chess_board.dart';
import 'package:chess_bot/gamechanger/PlayWithOnline.dart';
import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soundpool/soundpool.dart';

class Winner_page extends StatefulWidget {
  final String position;
  final String looser;
  Winner_page({
    Key key,
    this.position,
    this.looser,
  }) : super(key: key);

  @override
  State<Winner_page> createState() => _Winner_pageState();
}

class _Winner_pageState extends State<Winner_page> {
  @override
  void initState() {
    setState(() {
      winid=widget.looser==widget.position?'me':'op';

    });

    winner();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    sound().soundId.stop;

    // TODO: implement dispose
    super.dispose();
  }

  String winid = '';
  // Soundpool pownsound = Soundpool(streamType: StreamType.notification);
  @override
  Widget build(BuildContext context) {
    print(winid);
    print("aaaaaa");
    sound(audio: "assets/audio/winningsound.mp3");
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => bottom()));
            // Lobby(context);
          },
          label: Text("Go to Lobby"),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Color(0xff420108),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                      height: height * 0.45,
                      width: width * 0.73,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          // Color(0xff723033),
                          image: DecorationImage(image: AssetImage("assets/images/winnner.png")),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 30, left: 10, right: 10),
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.07,
                              width: width * 0.73,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xffbb8144),
                                        Color(0xffffffbe),
                                        Color(0xffffffbe),
                                        Color(0xff804c09),
                                        Color(0xffbb8144)
                                      ],
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("Real-Money-Chess",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: width * 0.07,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          // Text(" 🏆",style: TextStyle(fontSize:width*0.2,color: Colors.white),),


                         Padding(
                           padding: const EdgeInsets.only(left: 5),
                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                               widget.looser==widget.position?
                               Text(oname.split(" ").first,style: TextStyle(fontSize:width*0.073,fontWeight: FontWeight.w900,color: Colors.white)):
                               Text(username.split(" ").first,style: TextStyle(fontSize:width*0.073,fontWeight: FontWeight.w900,color: Colors.white)),
                                   // Text(" 🏆",style: TextStyle(fontSize: 20,color: Colors.white),),

                                 ]
                               ),
                         ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text("₹"+prize.toString(),style: TextStyle(fontSize: width*0.1,color: Color(0xffffc83d),fontWeight: FontWeight.w900)),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          //       primary:Color(0xffffffbe),
                          //       onPrimary: Color(0xff804c09)
                          //       // Background color
                          //     ),
                          //     onPressed: (){
                          //
                          //     }, child: Text(
                          //   "Back To Lobby",style: TextStyle(fontSize:width*0.05,fontWeight: FontWeight.w900),
                          // ))
                        ],
                      )),
                ),
                Positioned(
                    top: -height * 0.09,
                    child: Container(
                      width: width,
                      child: Center(
                          child: Image.asset(
                        "assets/images/rotatingcrown.gif",
                        scale: 3,
                      )),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  winner() async {
    print(winid);

    print(widget.position);
    print(widget.looser);
    print("winid😂😂😂😂😂");
    print("user id pprinted here winner api");
// print(widget.looser=='id'? Apiconst.winner+"$useid" :Apiconst.winner+"$opid");
    print("winnnnnnnerrrrrrrrrrrrr");
    String lsid = winid == 'me' ? useid : opid;

// String lsid=widget.position=="id"?useid:opid;
    print(lsid);
    print("😁😁😁😁lsid");

    final url = Apiconst.winner + "$lsid";
    final res = await http.get(Uri.parse(url));
    final data = jsonDecode(res.body);
    print(data);
  }
}
