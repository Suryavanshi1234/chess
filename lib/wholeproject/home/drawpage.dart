import 'dart:convert';

import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_board/flutter_chess_board.dart';
import 'package:chess_bot/gamechanger/PlayWithOnline.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Draw_page extends StatefulWidget {
  final String looser;
  Draw_page({Key key, this.looser, }) : super(key: key);

  @override
  State<Draw_page> createState() => _Draw_pageState();
}

class _Draw_pageState extends State<Draw_page> {
  @override
  void initState() {
    draw();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    sound(audio: "assets/audio/winningsound.mp3");
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(

        backgroundColor: Color(0xff420108),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [

                Center(
                  child: Container(

                      height: height*0.45,
                      width: width*0.73,
                      decoration: BoxDecoration(

                          color: Color(0xff723033),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 30,left: 10,right: 10),
                            child: Container(
                              alignment: Alignment.center,
                              height: height*0.07,
                              width: width*0.73,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Color(0xffbb8144),Color(0xffffffbe),Color(0xffffffbe),
                                        Color(0xff804c09),Color(0xffbb8144)],
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text("Real-Money-Chess",style: TextStyle(color: Colors.black,fontSize: width*0.07,fontWeight: FontWeight.w900)),
                            ),
                          ),
                          SizedBox(height: height*0.02,),
                          Container(alignment: Alignment.center,
                              height: height*0.05,
                              width: width*0.6,
                              decoration: BoxDecoration(

                                  border:Border.all(width: 1,color: Color(0xffffffbe)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("1.",style: TextStyle(fontSize: 20,color: Colors.white),),
                                  Text(username,style: TextStyle(fontSize: 20,color: Colors.white),),
                                  Text("₹ "+(double.parse(prize)/2).toString(),style: TextStyle(fontSize: 20,color: Color(0xffffc83d))),
                                  // Text(" 🏆",style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              )
                            // ListTile(
                            //
                            // ),
                          ),
                          SizedBox(height: height*0.02,),
                          Container(
                              height: height*0.05,
                              width: width*0.6,
                              decoration: BoxDecoration(
                                  border:Border.all(width: 1,color: Color(0xffffffbe)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("2.",style: TextStyle(fontSize: 20,color: Colors.white),),
                                  Text(oname,style: TextStyle(fontSize: 20,color: Colors.white),),
                                  Text("₹ "+(double.parse(prize)/2).toString(),style: TextStyle(fontSize: 20,color: Color(0xffffc83d))),
                                  // Text(" 👎",style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              )
                          ),
                          SizedBox(height: height*0.1,),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(

                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  primary:Color(0xffffffbe),
                                  onPrimary: Color(0xff804c09)
                                // Background color
                              ),
                              onPressed: (){}, child: Text(
                            "Back To Lobby",style: TextStyle(fontSize:width*0.05,fontWeight: FontWeight.w900),
                          ))
                        ],
                      )


                  ),
                ),
                Positioned(
                    top: -height*0.09,


                    child:
                    Container(
                      width: width,
                      child: Center(
                          child: Image.asset("assets/images/rotatingcrown.gif",scale: 3,)),
                    )
                ),

              ], ),

          ],
        ) ,
      ),
    );
  }
  draw()async{

    final url=Apiconst.Draw+"$useid";
    final res=await http.get(Uri.parse(url));
    final data=jsonDecode(res.body);
    print(data);
  }
}
