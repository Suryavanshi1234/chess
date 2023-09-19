
import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chess_bot/MainGameModel/PlayWithFriend/button_page.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_board/flutter_chess_board.dart';

import 'package:chess_bot/wholeproject/Dashboard/More.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:chess_bot/wholeproject/home/P_Friend_tablePage.dart';
import 'package:chess_bot/wholeproject/home/contestent.dart';
import 'package:chess_bot/wholeproject/home/freeplaycontestent.dart';
import 'package:chess_bot/wholeproject/home/online_table_Page.dart';
import 'package:chess_bot/wholeproject/home/table_page.dart';
import 'package:chess_bot/wholeproject/webview_freeplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:soundpool/soundpool.dart';

import '../More/constapi.dart';


class First_home_page extends StatefulWidget {
  const First_home_page({Key key}) : super(key: key);

  @override
  State<First_home_page> createState() => _First_home_pageState();
}

class _First_home_pageState extends State<First_home_page> {

  // void playMusic(String audioUrl) async {
  //   await _player.openAudioSession();
  //   await _player.startPlayer(
  //     fromURI: audioUrl,  // Replace with your audio URL
  //   );
  // }

  @override
  void initState() {
    // playMusic();
    SupportApi.fetchlauncherdata();
    SupportApi();

    // TODO: implement initState
    super.initState();
  }
  // Soundpool pool = Soundpool(streamType: StreamType.notification);
  void dispose() {

// pool.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: primaryColor,
        appBar: AppBar(elevation: 0,centerTitle: true,
          leading: CircleAvatar(backgroundColor: secondryColor,
              child: Image.asset("assets/images/ChessLogo.png")),
          title: Text(
            "Realmoneychess",
            style: TextStyle(
                color: primarytextColor, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          // title: Container(
          //   height: 15,
          //   width: 150,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage("assets/images/AppBar_name.png"),
          //     )
          //   ),
          // ),
          backgroundColor: primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context,)=>Details()));
                },
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: primarytextColor,
                ))
          ],

        ),
        body: Container(
          height:height*0.8,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/chessbg.jpg"),
                fit: BoxFit.fill,)),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
               SizedBox(height: MediaQuery.of(context).size.height/18,),
              Container(
                // color: Colors.red,
                // height: 200,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/slider1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/slider2.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // 3rd image
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/slider3.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    // height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 19 / 6,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.9,
                  ),
                ),
              ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap:()  async{
                     PlayOnlline_Join(entryfee: '0');
                    // bool canLaunchUrl = await canLaunch('https://chessweb.apponrent.co.in/#/');
                    //
                    // if (canLaunchUrl) {
                    //   // Launch the URL
                    //   await launch('https://chessweb.apponrent.co.in/#/');
                    // } else {
                    //   throw 'Could not launch URL';
                    // }
                    // final prefs = await SharedPreferences.getInstance();
                    // final userid=prefs.getString("userId");


                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => WebViewExample(
                    //           url:
                    //           "https://chess.apponrent.com/match/$userid/0.0",
                    //         )));
                    // Navigator.push(context, PageTransition(child: CreateTable(),
                    //     type: PageTransitionType.rightToLeft,duration:Duration(seconds: 1) ));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Find_Contestent()));
                  },
                    child: Container(
                      alignment: Alignment.center,
                      height: height*0.14,
                      width: width*0.4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Free_Play__1_.png"),fit: BoxFit.fill,)),


                    ),
                  ),SizedBox(width: width*0.09,),
                  InkWell(onTap: (){
                    // Navigator.push(context, PageTransition(child: Table_Page(),
                    //     type: PageTransitionType.rightToLeft,duration:Duration(seconds: 1) ));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Online_Table_Page(type:'3')));
                  },
                    child: Container(alignment: Alignment.center,
                      height: height*0.14,
                      width: width*0.4,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Free_Play__2.png"),fit: BoxFit.fill,)),


                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.04,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap:(){
                    // Navigator.push(context, PageTransition(child: Play_Friend_Tablepage(),
                    //     type: PageTransitionType.rightToLeft,duration:Duration(seconds: 1) ));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Create_Join(type:"1")));
                  },
                    child: Container(alignment: Alignment.center,
                      height: height*0.14,
                      width: width*0.4,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Free_Play__3.png"),fit: BoxFit.fill,)),
                    ),
                  ),SizedBox(width: width*0.09,),
                   InkWell(onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Table_Page(type:"4")));
                     // Navigator.push(context, PageTransition(child: Table_Page(),
                     //    type: PageTransitionType.rightToLeft,duration:Duration(seconds: 1) ));
                  },
                    child: Container(alignment: Alignment.center,
                      height: height*0.14,
                      width: width*0.4,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Free_Play_5.png"),fit: BoxFit.fill,)),


                    ),
                  ),
                ],
              ),

            ],
          ),
        ));
  }
  // String entryfee
  PlayOnlline_Join({ String entryfee}  )async{
    print("👍👍👍👍👍👍👍👍👍👍");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    // print(level);
    print("😂😂level");
    final response=await http.get(
      Uri.parse('https://apponrent.co.in/chess/api/joingame.php?userid=$userid&levelid=18'),
    );
    final data=jsonDecode(response.body);
    if(data["error"]=='200'){
      print("😂😂😂😂😂😂😂😂😂😂");
      // print(level);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Find_Contestent(entryfee:entryfee)));
    }else{

      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    print(data);
  }

}
String useid;