import 'dart:async';
import 'dart:convert';

import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_board/flutter_chess_board.dart';
import 'package:chess_bot/gamechanger/PlayWithOnline.dart';
import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:chess_bot/wholeproject/home/home1.dart';
import 'package:chess_bot/wholeproject/home/timerpage.dart';
import 'package:chess_bot/wholeproject/webview_freeplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:soundpool/soundpool.dart';

class free_contestent extends StatefulWidget {
 final String entryfee;
 final String creatdata;
  free_contestent({Key key,this.entryfee, this.creatdata});

  @override
  State<free_contestent> createState() => _free_contestentState();
}

class _free_contestentState extends State<free_contestent> {
  int ts=120;
  // Stream<String> timeStream;
  void initState() {
    viewprofile();
//    startTimer();
    // playGuest();
    // Future.delayed(const Duration(seconds: 20), () {
    //   insertTable();
    //
    // });
    Timer(Duration(seconds: 5), () =>opponent());
    super.initState();
  }

  Soundpool pool = Soundpool(streamType: StreamType.notification);
//   Timer countdownTimer;
//   Duration myDuration = Duration(seconds: 25);
//   void startTimer() {
//     countdownTimer =
//         Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//   }
//
//   void stopTimer() {
//     setState(() => countdownTimer.cancel());
//   }
// // Step 5
//   void resetTimer() {
//     stopTimer();
//     setState(() => myDuration = Duration(seconds: 10));
//   }
// Step 6

  DateTime _dateTime;
  bool frist=true;

  // void setCountDown() {
  //   final reduceSecondsBy = 1;
  //   _dateTime = DateTime.now().toUtc();
  //   setState(() {
  //     final seconds =10- int.parse(_dateTime.second.toString().split('').last) ;
  //     if (seconds == 0) {
  //
  //       startTimer();
  //       resetTimer();
  //     } else {
  //       myDuration = Duration(seconds: seconds);
  //     }
  //   });
  //
  //   if(frist==true){
  //
  //     setState(() {
  //       frist=false;
  //       final seconds=   10-_dateTime.second;
  //       myDuration = Duration(seconds: seconds);
  //
  //     });
  //
  //
  //   }else{
  //     print(myDuration.inSeconds);
  //     if(myDuration.inSeconds==1){
  //       opponent();
  //
  //
  //     }
  //   }
  //
  //
  // }
  @override
  void dispose() {
   // countdownTimer.cancel();
    pool.dispose();
    sound();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
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
              content: Text('Do you want to exit ', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    // dispose();
                    Refund (widget.entryfee,context);
                    // Navigator.pop(context,true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context,false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop;
      },
      child: SafeArea(child:
      Scaffold(
        body: Container(
          height: height,

          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff49001e),Color(0xff1F1C18)],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter

              )
          ),
          child:map==null?Center(child: CircularProgressIndicator()):
          //     : op==null?Center(
          //   child: CircularProgressIndicator(),
          // ):map==""?Center(child: CircularProgressIndicator()):op==""?Center(child: CircularProgressIndicator()):
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Container(
                alignment: Alignment.center,
                height: height*0.15,
                width: width*0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/Frame.png",),fit: BoxFit.fill
                    )
                ),
                child: Container(
                  height: height*0.12,
                  width: width*0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/Chess_logo2.png",),
                      )
                  ),
                ),
              ),
              SizedBox(height:height*0.08,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: height*0.15,
                      width: width*0.31,
                      decoration: BoxDecoration(
                          image: DecorationImage(filterQuality: FilterQuality.low,
                              image: AssetImage("assets/images/playnow.png"),fit: BoxFit.fill
                          )
                      ),
                      child: map["image"]==null? Container(alignment: Alignment.center,
                          height: height*0.15,
                          width: width*0.3,
                          decoration: BoxDecoration(
                              image: DecorationImage(filterQuality: FilterQuality.low,
                                  image: AssetImage("assets/images/playnow.png"),fit: BoxFit.fill
                              )
                          ),
                          child: Container(
                            height: height*0.12,
                            width: width*0.26,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/PYBr.gif"),fit: BoxFit.fill
                                )
                            ),
                          )
                      ):
                      Container(
                        height: height*0.122,
                        width: width*0.26,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image:  NetworkImage( Apiconst.Imageurl+map["image"]),fit: BoxFit.fill
                            )
                        ),
                      )
                  ),
                  Container(
                    height: height*0.16,
                    width: width*0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/giphy-unscreen.gif"),fit: BoxFit.fill
                        )
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: height*0.15,
                      width: width*0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(filterQuality: FilterQuality.low,
                              image: AssetImage("assets/images/playnow.png"),fit: BoxFit.fill
                          )
                      ),
                      child:
                       coin==false?
                      // InkWell(
                      //   onTap: (){
                      //     Share.share("Joine coode ${widget.creatdata}");
                      //   },
                      //   child: Container(
                      //     height: height*0.12,
                      //     width: width*0.26,
                      //     // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      //     //     image: DecorationImage(
                      //     //         image: AssetImage("assets/images/contestent.gif"),fit: BoxFit.fill
                      //     //     )
                      //     // ),
                      //     child: Icon(Icons.add,color: Colors.black,size: 100,),
                      //   ),
                      // )

                      InkWell(
                        onTap: (){
                           Share.share("Joine coode ${widget.creatdata}");
                        },
                        child: Container(
                          height: height*0.12,
                          width: width*0.26,
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          //     image: DecorationImage(
                          //         image: AssetImage("assets/images/contestent.gif"),fit: BoxFit.fill
                          //     )
                          // ),
                          child: Icon(Icons.add,color: Colors.black,size: 100,),
                        ),
                      )
                          :op==''? Container(
                        height: height*0.12,
                        width: width*0.26,

                        child: Icon(Icons.person,color: Colors.black,size: 100,),
                      ):  op['opponentimage']==null?
                      Container(
                        height: height*0.12,
                        width: width*0.26,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage("assets/images/contestent.gif"),fit: BoxFit.fill
                            )
                        ),
                      ):
                      Container(
                        height: height*0.12,
                        width: width*0.26,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(Apiconst.Imageurl+op['opponentimage']),fit: BoxFit.fill
                            )
                        ),
                      )
                  )
                  // Container(
                  //   alignment: Alignment.center,
                  //       height: height*0.15,
                  //       width: width*0.3,
                  //       decoration: BoxDecoration(
                  //           image: DecorationImage(filterQuality: FilterQuality.low,
                  //               image: AssetImage("assets/images/playnow.png"),fit: BoxFit.fill
                  //           )
                  //       ),
                  //   child: InkWell(
                  //     onTap: (){
                  //       Share.share("Joine coode ${widget.creatdata}");
                  //     },
                  //     child: Container(
                  //                height: height*0.12,
                  //                width: width*0.26,
                  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  //                   // image: DecorationImage(
                  //                   //     image: AssetImage("assets/images/contestent.gif"),fit: BoxFit.fill
                  //                   // )
                  //               ),
                  //                child: Icon(Icons.add,color: Colors.black,size: 100,),
                  //              ),
                  //   ),
                  //
                  // )

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    Container(alignment: Alignment.center,
                        height: height*0.05,
                        width: width*0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/infobutton.png",)
                          ),
                        ),
                        child: Text(map["fullname"].toString().split(" ").first== null?"wait...":
                        map["fullname"].toString().split(" ").first,style: TextStyle(color: Colors.white),)),
                    SizedBox(width: width*0.46,),
                    coin==false?Container():
                    Container(
                        alignment: Alignment.center,
                        height: height*0.05,
                        width: width*0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/infobutton.png",)
                          ),
                        ),
                        child: Container(
                          child: Center(
                            child: Text(op==''? 'Guest':op['opponentname'].toString().split(" ").first==null?"wait...":
                            op['opponentname'].toString().split(' ').first,style: TextStyle(color: Colors.white)),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                height: height*0.2,
                width: width*0.4,

                decoration:coin==true? BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/fallingcoin.gif",),fit: BoxFit.fill)):

                BoxDecoration(
                    color: Colors.transparent),
              ),
              // child: Image(image: AssetImage("assets/images/falling.gif",),height: height*0.15,
              coin==false?Container():
              Container(alignment: Alignment.center,
                height: height*0.025,
                width: width*0.2,
                decoration: BoxDecoration(

                    image: DecorationImage(image: AssetImage("assets/images/infobutton.png",),fit: BoxFit.fill
                    )
                ),
                child: Text("0.0",style: TextStyle(color: Colors.white,fontSize: 10),),),
              Text(
                '1',
                // myDuration.inSeconds.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      )),
    );
  }
  bool coin=false;
  var map;
  var op;
  viewprofile() async {
    print("😂😂😂😂😂");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    print(userid);
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
      sound3(audio: "assets/audio/findsound.mp3");
      int soundId = await rootBundle.load("assets/audio/findsound.mp3").then((ByteData soundData) {
        return pool.load(soundData);
      });
      int streamId = await pool.play(soundId,repeat: 2, rate: 0.70);

    }
  }
  String prizepool;
  var tid;
  opponent()async{
    // stopTimer();

    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    print(userid);
    print(Apiconst.Odetaileswithfriend+"userid=$userid&roomcode=${widget.creatdata}");
    print("🪙🪙🪙🪙🪙🪙🪙🪙");
    print("👨‍🦱👨‍🦱👨‍🦱👨‍🦱");
    final response = await http.get(
      Uri.parse(Apiconst.Odetailes+"userid=$userid"),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("😢😢😢😢😢");
    if(data["error"] == '400'){
      prizepool=data['winningamount'];
      Timer(Duration(seconds: 5), () =>opponent());

      //  Timer(Duration(seconds: 5), () =>
      //      Navigator.push(context,
      //          MaterialPageRoute(builder: (context) =>Timer_page(opid:op['opponentid']==null?'0':op['opponentid'].toString(),
      //              table:op['tid']==null?'0':op['tid'].toString(),prizepool:widget.entryfee==null?"0":widget.entryfee,
      //              // prizepool:op['winningamount']==null?'0':op['winningamount'].toString(),
      //              opname:op['opponentname']==null?'0':op['opponentname'].toString(),opimage:op['opponentimage']==null?'0':op['opponentimage'].toString(),
      //              position:data['postion']==null?'':data['postion'].toString()))));
    }

    if (data["error"] == '200') {


      setState(() {
        op = data['data'];
        coin=true;
        tid= data["tableno"];
      });

        sound(audio: "assets/audio/coinsound.mp3");

        Timer(Duration(seconds: 5), () {

            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>Timer_page(opid:op['opponentid']==null?'0':op['opponentid'].toString(),
                    table:op['tid']==null?'0':op['tid'].toString(),prizepool:widget.entryfee==null?"0":widget.entryfee,
                    // prizepool:op['winningamount']==null?'0':op['winningamount'].toString(),
                    opname:op['opponentname']==null?'0':op['opponentname'].toString(),opimage:op['opponentimage']==null?'0':op['opponentimage'].toString(),
                    position:data['postion']==null?'':data['postion'].toString())));
            insertTable();
            print("😂😂😂😂insertTable");
            print(insertTable);
            print("😂😂😂😂insertTable");
        }
        );
      }

  }
  Refund( String rupees, BuildContext context) async{
    // stopTimer();
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    // setState(() {
    //   loading=true;
    // });

    final response=await http.post(
      Uri.parse(Apiconst.Deposit_money),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid" : '${userid}' ,

        "amount":rupees,
        "discription":"Refund Money"


      }),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottom()));
  }
  insertTable()async{
    print("fun invoked");
    final res = await http.get(Uri.parse("https://apponrent.co.in/chess/api/tableupdatestatus.php?tableno=$tid"));
    var data = jsonDecode(res.body);
    if (data["error"] == '200') {

      // print(data);
    }else{
      throw Exception();

    }
  }
  // playGuest()async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final userid=prefs.getString("userId");
  //           Timer(Duration(seconds: 40), () =>Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //   builder: (context) => WebViewExample(
  //   url:
  //   "https://chess.apponrent.com/match/$userid/$prizepool",
  //   ))));
  //
  // }
}

