
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_board/chess.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_control/chess_controller.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/util/online_game_utils.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_board/flutter_chess_board.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/chess_board/src/chess_sub.dart' as chess_sub;
import 'package:chess_bot/MainGameModel/PlayWithOnline/util/utils.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/util/widget_utils.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/widgets/divider.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/widgets/fancy_button.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/widgets/fancy_options.dart';
import 'package:chess_bot/MainGameModel/PlayWithOnline/widgets/modal_progress_hud.dart';
import 'package:chess_bot/generated/i18n.dart';
import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:chess_bot/wholeproject/constwidget/onlline_slider.dart';
import 'package:chess_bot/wholeproject/home/home1.dart';
import 'package:chess_bot/wholeproject/home/table_page.dart';
import 'package:chess_bot/wholeproject/home/winnerpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;
import 'package:percent_indicator/circular_percent_indicator.dart';




S strings;
ChessController _chessController;
OnlineGameController _onlineGameController;
SharedPreferences prefs;
String uuid;
bool tchange=false;


class PlayWithOnline extends StatelessWidget {
  final String opid;
  final String table;
  final String prizepool;
  final String opname;
  final String opimage;
  final String position;



  PlayWithOnline({Key key, this.opid, this.table, this.prizepool, this.opname, this.opimage, this.position}) : super(key: key);




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //set fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);
    //and portrait only
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //create the material app
    return MaterialApp(
      //manage resources first
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      //define title etc.
      title: 'app_name',
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(opid:opid, table:table,prizepool:prizepool, opname:opname,opimage:opimage,position:position),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String opid;
  final String table;
  final String prizepool;
  final String opname;
  final String opimage;
  final String position;



  MyHomePage({Key key, this.opid, this.table, this.prizepool, this.opname, this.opimage, this.position}) : super(key: key);

  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  Future<void> _loadEverythingUp() async {
    //load the old game
    await _chessController.loadOldGame();
    //set the king in chess board
    _chessController.setKingInCheckSquare();
    //await prefs
    prefs = await SharedPreferences.getInstance();
    //load values from prefs
    //the chess controller has already been set here!
    _chessController.botColor =
        chess_sub.Color.fromInt(prefs.getInt('bot_color') ?? 1);
    _chessController.whiteSideTowardsUser =
        prefs.getBool('whiteSideTowardsUser') ?? true;
    _chessController.botBattle = prefs.getBool('botbattle') ?? false;
    // _chessController.controller.refreshBoard();
    //load user id and if not available create and save one
    uuid = prefs.getString('uuid');

    if (uuid == null) {
      uuid = Uuid().v4();
      prefs.setString('uuid', uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    //set strings object
    strings ??= S.of(context);
    //init the context singleton object
    ContextSingleton(context);
    //build the chess controller,
    //if needed set context newly
    if (_chessController == null)
      _chessController = ChessController(context);

    else
      _chessController.context = context;
    //create the online game controller if is null
    _onlineGameController ??= OnlineGameController(_chessController);

    //future builder: load old screen and show here on start the loading screen,
    //when the future is finished,
    //with setState show the real scaffold
    //return the view
    return (_chessController.game == null)
        ? FutureBuilder(

      future: _loadEverythingUp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            var error = snapshot.error;
            print('$error');
            return Center(child: Text(strings.error));
          }

          return MyHomePageAfterLoading(opid:widget.opid, table:widget.table,prizepool:widget.prizepool, opname:widget.opname, opimage:widget.opimage,position:widget.position);
        } else {
          return Center(
              child: ModalProgressHUD(
                child: Container(),
                inAsyncCall: true,
              ));
        }
      },
    )
        :            MyHomePageAfterLoading(opid:widget.opid, table:widget.table,prizepool:widget.prizepool, opname:widget.opname,opimage:widget.opimage,position:widget.position
    );

  }
}

class MyHomePageAfterLoading extends StatefulWidget {
  final String opid;
  final String table;
  final String prizepool;
  final String opname;
  final String opimage;
  final String position;



  MyHomePageAfterLoading({Key key, this.opid, this.table, this.prizepool, this.opname, this.opimage, this.position}) : super(key: key);
  @override
  _MyHomePageAfterLoadingState createState() => _MyHomePageAfterLoadingState();
}

class _MyHomePageAfterLoadingState extends State<MyHomePageAfterLoading>

    with WidgetsBindingObserver {


  @override


  void initState() {
    viewprofile();

  startTimer();
    super.initState();
    prefs.setBool("bot", false);
    WidgetsBinding.instance.addObserver(this);
    // _chessController.controller.resetBoard();
    if(widget.position =="id"){

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PlayWithFriends(roomcode: 'create',)));
      _onlineGameController.finallyCreateGameCode(widget.table);
      // Text("")
      print(widget.table);
      print("🌐🌐🌐🌐🌐🌐🌐");
    }else{

      Future.delayed(const Duration(seconds: 2), () {

// Here you can write your code

        _onlineGameController.joinGame(widget.table);


      });

      print(widget.table);
      print("🌐🌐🌐🌐🌐🌐🌐widget.table");
      // _onJoinCode;
    }





    // if(widget.position=='id'){
    //   if(widget.opid != useid){
    //     setState(() {
    //       turnblock=Container(
    //           height: MediaQuery.of(context).size.height,
    //           width: MediaQuery.of(context).size.width,
    //           color: Colors.white
    //       );
    //     });
    //   }
    // }



    _chessController?.makeBotMoveIfRequired();

    WidgetsBinding.instance.addObserver(this);
  }
  Soundpool poolsound = Soundpool(streamType: StreamType.notification);

  @override
  void dispose() {


    WidgetsBinding.instance.removeObserver(this);
   _chessController.controller.resetBoard();
    poolsound.dispose();
    stopTimer();
    // setCountDown();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _chessController.saveOldGame();

        break;
      default:
        break;
    }
  }
  List p=<String>[];
  List P=<String>[];
List k=<String>[];
List K=<String>[];
  List b=<String>[];
  List B=<String>[];
  List n=<String>[];
  List N=<String>[];
  List r=<String>[];
  List R=<String>[];
  List Q=<String>[];
  List q=<String>[];

  pj(){

    String str = _chessController.game.fen;
    var data=str.split(' ');
    String frist=data.first.toString();

    String result = frist.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    String outputString = result.replaceAll(RegExp(r'\d+'), '');
    // Removes all numbers
    var dta=outputString.split('');
    print(outputString);

    K.clear();
    k.clear();
    B.clear();
    b.clear();
    n.clear();
    N.clear();
    r.clear();
    R.clear();
    q.clear();
    Q.clear();
    p.clear();
    P.clear();
    print(dta.length);
    print('amo');
    for(var i=0;i<dta.length; i++){
      print(dta);
      print("👑👑👑👑👑");

      if(dta[i]=='K'){

        K.add(dta[i]);
      }
      if(dta[i]=='k'){

        k.add(dta[i]);
      }
      if(dta[i]=='B'){

        B.add(dta[i]);
      }
      if(dta[i]=='b'){

        b.add(dta[i]);
      }

      if(dta[i]=='n')
      {
        n.add(dta[i]);
      }
      if(dta[i]=='N'){

        N.add(dta[i]);
      }
      if(dta[i]=='r'){

        r.add(dta[i]);
      }
      if(dta[i]=='R'){

        R.add(dta[i]);
      }
      if(dta[i]=='q'){

        q.add(dta[i]);
      }
      if(dta[i]=='Q'){

        Q.add(dta[i]);
      }
      if(dta[i]=='p'){

        p.add(dta[i]);
      }
      if(dta[i]=='P'){
        P.add(dta[i]);
      }

    }


  }

  Container turnblock = Container();

  void update() {
    setState(() {});
    pj();

  }
  Future<bool> _onWillPop() async {
    // _chessController.saveOldGame();
    return true;
  }

  bool  swetapagal = true;
  int streamId;
  int soundId;
  double height = 600;
  double width = 350;

  Timer countdownTimer;
  int seconds=100;

  void startTimer() {
    print('testtime');
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_)  {setCountDown();});
  }

  void stopTimer() {
    setState(() => countdownTimer.cancel());
  }
// Step 5
  void resetTimer() {
    stopTimer();
    setState(() { seconds=100;});
  }
// Step 6
bool winner = false;
  DateTime _dateTime;
  bool frist=true;
double pertime=1.0;

// Container turnbloc=Container();

  void setCountDown() {

      final reduceSecondsBy = 1;
      if(winner ==false)
      setState(() {
        if (seconds == 1) {
          stopTimer();
          winner = true ;
          print("kkkkkkkkkkkkkkkkkkkkkkk");
print(_chessController?.game?.game?.turn);

// print(_chessController?.game?.game?.turn=="oid"?useid:opid);
print(_chessController?.game?.game?.turn ==
    chess_sub.Color.WHITE ? chess_sub.Color.WHITE : chess_sub.Color.BLACK);
          // stopTimer();
          String winid='';
          String t=strings.turn_of_x(
              (_chessController?.game?.game?.turn ==
                  chess_sub.Color.BLACK)
                  ? strings.black
                  : strings.white).toLowerCase();
          final tp= t=="black's turn".toLowerCase()?'oid':'id';

          _chessController.game.reset();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              Winner_page(position:widget.position,looser:tp

              // _chessController?.game?.game?.turn ==
              //     chess_sub.Color.WHITE ? chess_sub.Color.WHITE.toString() :chess_sub.Color.BLACK.toString()
              //
              )));
          // Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //     Winner_page(looser: _chessController?.game?.game?.turn=="oid"?useid:opid)));
          // startTimer();
          // resetTimer();
        } else {
          setState(() {
            seconds = seconds - reduceSecondsBy;
            pertime = seconds / 100;
          });
          if (_chessController?.game?.game?.turn ==
              chess_sub.Color.BLACK && tchange == false) {

            startTimer();
            resetTimer();

            setState(() {
              myturn='oid';
              tchange = true;
            });

          } else if (_chessController?.game?.game?.turn ==
              chess_sub.Color.WHITE && tchange == false) {



            startTimer();
            resetTimer();
            setState(() {
              myturn='id';
              tchange = true;
            });
            // if(widget.position=='id'){
            //   if(widget.opid != useid){
            //     setState(() {
            //       turnbloc=Container(
            //           height: MediaQuery.of(context).size.height,
            //           width: MediaQuery.of(context).size.width,
            //           color: Colors.white
            //       );
            //     });
            //   }
            // }

          }

print('yyyyyyyyyyyyyyyyyyyyyyyy');
print(widget.position);
print(widget.opid);
print(playerid.toString());
          if(widget.position=='oid')
          {
            if(widget.opid != playerid.toString()){
              if(_chessController?.game?.game?.turn ==
                  chess_sub.Color.BLACK){
                setState(() {
                  turnblock = Container();

                });
              }else {
                setState(() {
                  turnblock = Container(
                      height: height,
                      width: width,
                      color: Colors.grey.withOpacity(0.2)
                  );
                });
              }
            }
          }
           if (widget.position=='id'){
            if(widget.opid != playerid.toString()){
              if(_chessController?.game?.game?.turn ==
                  chess_sub.Color.BLACK){
                setState(() {
                  turnblock=Container(
                      height: height,
                      width: width,
                      color:Colors.grey.withOpacity(0.2)
                  );
                });

              }else{
                setState(() {
                  turnblock = Container();

                });
              }
            }
          }
          // ?resetTimer():winner('white');


        }
      });


//           if (seconds == 1) {
//             setState(() {
//               stopTimer();
//               winner = true ;
//               print("kkkkkkkkkkkkkkkkkkkkkkk");
//               print(_chessController?.game?.game?.turn);
// // print(_chessController?.game?.game?.turn=="oid"?useid:opid);
//               print(_chessController?.game?.game?.turn ==
//                   chess_sub.Color.WHITE ? chess_sub.Color.WHITE : chess_sub.Color.BLACK);
//               // stopTimer();
//               _chessController.game.reset();
//               Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                   Winner_page(position:widget.position,looser: _chessController?.game?.game?.turn ==
//                       chess_sub.Color.WHITE ? chess_sub.Color.WHITE.toString() :chess_sub.Color.BLACK.toString())));
//             });
//
//             // Navigator.push(context, MaterialPageRoute(builder: (context) =>
//             //     Winner_page(looser: _chessController?.game?.game?.turn=="oid"?useid:opid)));
//             // startTimer();
//             // resetTimer();
//           } else {
//             setState(() {
//               seconds = seconds - reduceSecondsBy;
//               pertime = seconds / 100;
//             });
//
//             if (_chessController?.game?.game?.turn ==
//                 chess_sub.Color.BLACK && tchange == false) {
//
//               startTimer();
//               resetTimer();
//
//               setState(() {
//                 myturn='oid';
//                 tchange = true;
//               });
//               // if(widget.position=='oid'){
//               //   if(widget.opid != useid){
//               //     setState(() {
//               //       turnblock=Container(
//               //         height: MediaQuery.of(context).size.height,
//               //         width: MediaQuery.of(context).size.width,
//               //         color: Colors.black
//               //       );
//               //     });
//               //   }
//               // }
//
//
//
//             } else if (_chessController?.game?.game?.turn ==
//                 chess_sub.Color.WHITE && tchange == false) {
//               startTimer();
//               resetTimer();
//               setState(() {
//                 myturn='id';
//                 tchange = true;
//               });
//               // if(widget.position=='id'){
//               //   if(widget.opid != useid){
//               //     setState(() {
//               //       turnbloc=Container(
//               //           height: MediaQuery.of(context).size.height,
//               //           width: MediaQuery.of(context).size.width,
//               //           color: Colors.white
//               //       );
//               //     });
//               //   }
//               // }
//
//             }
//
//             print('yyyyyyyyyyyyyyyyyyyyyyyy');
//             print(widget.position);
//             print(widget.opid);
//             print(playerid.toString());
//             if(widget.position=='opid')
//             {
//               if(widget.opid != playerid.toString()){
//                 if(_chessController?.game?.game?.turn ==
//                     chess_sub.Color.BLACK){
//                   setState(() {
//                     turnblock = Container();
//
//                   });
//                 }else {
//                   setState(() {
//                     turnblock = Container(
//                         height: height,
//                         width: width,
//                         color: Colors.grey.withOpacity(0.2)
//                     );
//                   });
//                 }
//               }
//             }
//             if (widget.position=='id'){
//               if(widget.opid != playerid.toString()){
//                 if(_chessController?.game?.game?.turn ==
//                     chess_sub.Color.BLACK){
//                   setState(() {
//                     turnblock=Container(
//                         height: height,
//                         width: width,
//                         color:Colors.grey.withOpacity(0.2)
//                     );
//                   });
//
//                 }else{
//                   setState(() {
//                     turnblock = Container();
//
//                   });
//                 }
//               }
//             }
//             // ?resetTimer():winner('white');
//
//
//           }


  }

bool t=true;

  String myturn='';
winnerr(String w)async{
    print(w);
    print('raja');
}
  @override
  Widget build(BuildContext context) {

     width = MediaQuery.of(context).size.width;
     height = MediaQuery.of(context).size.height;
    //get the available height for the chess board
    double availableHeight = MediaQuery.of(context).size.height - 184.3;
    //set the update method
    _chessController.update = update;
    //set the update method in the online game controller
    _onlineGameController.update = update;
    //the default scaffold
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
                content: Text('Do you want to exit from App', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
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
    child:


      map==null?Center(
      child: CircularProgressIndicator(),
    ):ModalProgressHUD(
      inAsyncCall: ChessController.loadingBotMoves,
      progressIndicator: kIsWeb
          ? Text(
        strings.loading_moves_web,
        style: Theme.of(context).textTheme.subtitle2,
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text(
            strings.moves_done(_chessController.progress),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
      child: SafeArea(

        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor:primaryColor,
            onPressed: () {
              Lobby(context);
            },
            label: Text("Go to Lobby"),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.brown[50],
          body: Container(
            height:height,
            width: width,
            decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),fit: BoxFit.fill
            )),
            child: Stack(
               // clipBehavior: null,

              children: [


               
               
                Positioned(
                    left: 10,
                    top:10,
                    child:
                    IconButton(
                        onPressed:
                        swetapagal?
                            ()async{
                          int soundId = await rootBundle.load("assets/audio/audiomain.mp3").then((ByteData soundData) {
                            return poolsound.load(soundData);
                          });
                          streamId = await poolsound.play(soundId,repeat: 100);
                          // _playCheering();
                          setState(() {
                            swetapagal=false;
                          }) ;}
                            :    (){
                          poolsound.stop(streamId);
                          // _playCheering();
                          setState(() {
                            swetapagal=true;
                          });

                        },

                        icon:Icon(
                          swetapagal?
                          Icons.volume_off :Icons.volume_up,color:
                        swetapagal?
                        Colors.green:Colors.red,))
                ),

                Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                            child:Column(
                              children: [
                                Container(
                                    height: height*0.08,
                                    width: width*0.4,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Colors.pink,Colors.red],
                                          end: Alignment.bottomCenter,
                                          begin: Alignment.topCenter

                                      ),
                                      border: Border.all(color: Colors.white,width: 2),
                                      borderRadius: BorderRadius.all(Radius.circular(30),
                                      ),

                                    ),
                                    child: Column(
                                      children: [
                                        Text("🏆",style: TextStyle(color: Color(0xffffdf00),
                                            fontSize: 18,fontWeight: FontWeight.w600),),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text("Prize: ",
                                                style: TextStyle(color: Color(0xffffdf00),
                                                    fontSize: 15,fontWeight: FontWeight.w600),
                                              ),
                                              Text(" ₹ "+widget.prizepool,style: TextStyle(color: Colors.white,
                                                  fontSize: 15,fontWeight: FontWeight.w600))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                SizedBox(height: height*0.05,),


                                Stack(
                                  clipBehavior: Clip.none,

                                  children: [
                                    widget.position=='id'?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        map==null?Container(
                                          height: height*0.1,
                                          width: width*0.4,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.15,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter

                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Icon(Icons.person, color: Colors.grey, size: 35,))),
                                            title: Text("Guest",
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                            subtitle: Text('kkbk',
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                          ),
                                        ):
                                        map["image"]==null?Container(
                                          height: height*0.1,
                                          width: width*0.4,
                                          // padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.15,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter
                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Icon(Icons.person, size:30 ,))),
                                            title: Text("Guest",
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                            subtitle: Text('kkbk',
                                              style: TextStyle(color: Colors.black,fontSize: 15),),
                                          ),
                                        ):
                                        Container(
                                          height: height*0.1,
                                          width: width*0.429,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.14,
                                                decoration: BoxDecoration(
                                                   color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter

                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Image.network(Apiconst.Imageurl+map["image"]))),
                                            title: Text(
                                               map['fullname']==null?'':map['fullname'].toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 10),),
                                            subtitle:  Text('♔'+(1-k.length).toString()+
                                              '♘'+(2-n.length).toString()
                                                +'♗'+(2-b.length).toString()
                                                +'♕'+(1-q.length).toString()
                                                +'♖'+(2-r.length).toString()
                                                +'♙'+(8-p.length).toString()
                                              ,style: TextStyle(color: Colors.white,fontSize: 12),),
                                          ),
                                        ),




                                        Container(
                                          height: height*0.1,
                                          width: width*0.429,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.14,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter

                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Image.network(Apiconst.Imageurl+widget.opimage))),
                                            title: Text(widget.opname.split(" ").first,
                                              style: TextStyle(color: Colors.white,fontSize: 10),),
                                            subtitle: Text('♔'+(1-k.length).toString()+
                                                  '♘'+(2-N.length).toString()
                                                +'♗'+(2-B.length).toString()
                                                +'♕'+(1-Q.length).toString()
                                                +'♖'+(2-R.length).toString()
                                                +'♙'+(8-P.length).toString()
                                              ,style: TextStyle(color: Colors.red,fontSize: 12),),
                                          ),
                                        ),



                                      ],
                                    ):  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: height*0.1,
                                          width: width*0.429,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.14,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter

                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Image.network(Apiconst.Imageurl+widget.opimage))),
                                            title: Text(widget.opname.split(" ").first,
                                              style: TextStyle(color: Colors.white,fontSize: 10),),
                                            subtitle: Text('♔'+(1-k.length).toString()+
                                              '♘'+(2-N.length).toString()
                                                +'♗'+(2-B.length).toString()
                                                +'♕'+(1-Q.length).toString()
                                                +'♖'+(2-R.length).toString()
                                                +'♙'+(8-P.length).toString()
                                              ,style: TextStyle(color: Colors.red,fontSize: 12),),
                                          ),
                                        ),
                                        map==null?Container(
                                          height: height*0.1,
                                          width: width*0.4,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.15,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter

                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Icon(Icons.person, color: Colors.grey, size: 35,))),
                                            title: Text("Guest",
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                            subtitle: Text('kkbk',
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                          ),
                                        ):
                                        map["image"]==null?Container(
                                          height: height*0.1,
                                          width: width*0.4,
                                          // padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.15,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter
                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Icon(Icons.person, size:30 ,))),
                                            title: Text("Guest",
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                            subtitle: Text('kkbk',
                                              style: TextStyle(color: Colors.black,fontSize: 15),),
                                          ),
                                        ):
                                        Container(
                                          height: height*0.1,
                                          width: width*0.429,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                             // color: Colors.yellow,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                                height:  height*0.1,
                                                width:  width*0.14,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(5),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xff49001e),Color(0xff1F1C18)],
                                                        end: Alignment.bottomCenter,
                                                        begin: Alignment.topCenter

                                                    ),
                                                    border: Border.all(color: Colors.yellow,width: 2)
                                                ),
                                                child: Center(child: Image.network(Apiconst.Imageurl+map["image"]))),
                                            title: Text(
                                              map['fullname']==null?'':map['fullname'].toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 10),),
                                            subtitle:  Text('♔'+(1-k.length).toString()+
                                              '♘'+(2-n.length).toString()
                                                +'♗'+(2-b.length).toString()
                                                +'♕'+(1-q.length).toString()
                                                +'♖'+(2-r.length).toString()
                                                +'♙'+(8-p.length).toString()
                                              ,style: TextStyle(color: Colors.white,fontSize: 12),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: _chessController?.game?.game?.turn !=
                                          chess_sub.Color.BLACK ? EdgeInsets.only(left: width*0.05,top: 12)
                                      :  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.62,top: 12),
                                      child: CircularPercentIndicator(
                                        radius:25,
                                        lineWidth: 40,
                                        percent: pertime,
                                        progressColor:Colors.blue.withOpacity(0.5),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            )
                          ),

                                Text(
                                    strings.turn_of_x(
                                        (_chessController?.game?.game?.turn ==
                                            chess_sub.Color.BLACK)
                                            ? strings.black
                                            : strings.white),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                      inherit: true,
                                      color: (_chessController?.game
                                          ?.in_check() ??
                                          false)
                                          ? ((_chessController.game
                                          .inCheckmate(
                                          _chessController.game
                                              .moveCountIsZero()))
                                          ? Colors.purple
                                          : Colors.red)
                                          : Colors.white,
                                    )),
                           Text(widget.table,style: TextStyle(color: Colors.white),),
                          //     ],
                          //   ),
                          // ),

                          Center(
                            // Center is a layout  It takes a single child and positions it
                            // in the middle of the parent.
                            child: SafeArea(
                              child: ChessBoard(
                                boardType: boardTypeFromString(
                                    prefs.getString('board_style') ?? 'g'),
                                size: min(MediaQuery.of(context).size.width,
                                    availableHeight),
                                onCheckMate: _chessController.onCheckMate,
                                onDraw: _chessController.onDraw,
                                onMove: _chessController.onMove,
                                onCheck: _chessController.onCheck,
                                chessBoardController:
                                _chessController.controller,
                                chess: _chessController.game,
                                whiteSideTowardsUser:
                                _chessController.whiteSideTowardsUser,


                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),

                Positioned(
                    top:0,
                    left: 1,
                    child: turnblock)


              ],
            ),
          ),
        ),
      ),
    ));
  }
  var map;
  void _onJoinCode() {
    //dialog to enter a code
    showAnimatedDialog(
        title: strings.enter_game_id,
        onDoneText: strings.join,
        icon: Icons.transit_enterexit,
        withInputField: true,
        inputFieldHint: strings.game_id_ex,
        onDone: (value) {
          _onlineGameController.joinGame(value);
        });
  }

  String playerid;

  viewprofile() async {
    print(prize);
    setCountDown();//
    print("😂😂😂😂😂");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    setState(() {
      playerid=userid;
    });
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
        useid=map['id'];
        opid=widget.opid;
        prize=widget.prizepool.toString();
        uimge=Apiconst.Imageurl+map['image'];
        oimge=Apiconst.Imageurl+widget.opimage;
        oname=widget.opname;
        username=map['fullname'];
        position=widget.position;


      });
      print("👑👑👑useid");
print(useid);
print("👑👑👑useid");
    }
    pj();
  }

}

 Lobby(BuildContext context) async{
  print("ooooooooooooooooooooo😁😁😁");

   final prefs = await SharedPreferences.getInstance();
   final userid=prefs.getString("userId");
  print(userid);
   final url="https://apponrent.co.in/chess/api/winlobby.php?userid=$userid";
   final res=await http.get(Uri.parse(url));
   final data=jsonDecode(res.body);
   print(data);
   if( data["error"]=="200"){
       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>First_home_page()));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottom()));

   }
}

String useid;
String opid;
String prize;
String uimge;
String oimge;
String oname;
String username;
String position;



Draw() async {
  print("😂😂😂😂😂");
  final prefs = await SharedPreferences.getInstance();
  final userid=prefs.getString("userId");
  print(userid);
  final response = await http.get(
    Uri.parse(Apiconst.Draw+"userid=$userid"),
  );
  var data = jsonDecode(response.body);
  print(data);
}
