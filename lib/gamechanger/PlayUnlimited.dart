import 'dart:convert';
import 'dart:math';


import 'package:chess_bot/MainGameModel/PlayUnlimited/chess_board/src/chess_board.dart';
import 'package:chess_bot/MainGameModel/PlayUnlimited/chess_control/chess_controller.dart';
import 'package:chess_bot/MainGameModel/PlayUnlimited/util/online_game_utils.dart';
import 'package:chess_bot/MainGameModel/PlayUnlimited/util/utils.dart';
import 'package:chess_bot/MainGameModel/PlayUnlimited/util/widget_utils.dart';
import 'package:chess_bot/MainGameModel/PlayUnlimited/widgets/fancy_button.dart';
import 'package:chess_bot/MainGameModel/PlayUnlimited/widgets/fancy_options.dart';
import 'package:chess_bot/MainGameModel/PlayUnlimited/widgets/modal_progress_hud.dart';
import 'package:chess_bot/generated/i18n.dart';
import 'package:chess_bot/main.dart';

import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:chess_bot/wholeproject/constant.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;

import 'package:chess_bot/MainGameModel/PlayUnlimited/chess_board/src/chess_sub.dart' as chess_sub;


S strings;
ChessController _chessController;
OnlineGameController _onlineGameController;
SharedPreferences prefs;
String uuid;


class PlayUnlimited extends StatelessWidget {
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
      title: app_name,
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
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

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
    //load user id and if not available create and save one
    uuid = prefs.getString('uuid');
    uuid = prefs.getString('uuid');
    if (uuid == null) {
      uuid = await PlatformDeviceId.getDeviceId;
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

          return MyHomePageAfterLoading();
        } else {
          return Center(
              child: ModalProgressHUD(
                child: Container(),
                inAsyncCall: true,
              ));
        }
      },
    )
        : MyHomePageAfterLoading();
  }
}

class MyHomePageAfterLoading extends StatefulWidget {
  MyHomePageAfterLoading({Key key}) : super(key: key);

  @override
  _MyHomePageAfterLoadingState createState() => _MyHomePageAfterLoadingState();
}

class _MyHomePageAfterLoadingState extends State<MyHomePageAfterLoading>
    with WidgetsBindingObserver {
  @override
  void initState() {
    viewprofile();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

  void update() {
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    _chessController.saveOldGame();
    return true;
  }

  void _onAbout() async {
    //show the about dialog
    showAboutDialog(
      context: context,
      applicationVersion: version,
      applicationIcon: Image.asset(
        'res/drawable/ic_launcher.png',
        width: 50,
        height: 50,
      ),
      applicationLegalese: await rootBundle.loadString('res/licenses/this'),
      children: [
        FancyButton(
          onPressed: () => launch(strings.privacy_url),
          text: strings.privacy_title,
        )
      ],
    );
  }

  void _onWarning() {
    showAnimatedDialog(
        title: strings.warning,
        forceCancelText: 'no',
        onDoneText: 'yes',
        icon: Icons.warning,
        onDone: (value) {},
        children: [Image.asset('res/drawable/moo.png')]);
  }

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

  void _onCreateCode() {
    //if is currently in a game, this will disconnect from all local games, reset the board and create a firestore document
    showAnimatedDialog(
      title: strings.warning,
      text: strings.game_reset_join_code_warning,
      onDoneText: strings.proceed,
      icon: Icons.warning,
      onDone: (value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottom()));

        if (value == 'ok') _onlineGameController.finallyCreateGameCode();
      },
    );
  }

  void _onLeaveOnlineGame() {
    //show dialog to leave the online game
    showAnimatedDialog(
      title: strings.leave_online_game,
      text: strings.deleting_as_host_info,
      icon: Icons.warning,
      onDoneText: strings.ok,
      onDone: (value) {
        if (value == 'ok') _onlineGameController.leaveGame();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottom()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    //get the available height for the chess board
     double availableHeight = MediaQuery.of(context).size.height - 184.3;
    //set the update method
    _chessController.update = update;
    //set the update method in the online game controller
    _onlineGameController.update = update;
    //the default scaffold
    return map==null?Center(
      child: CircularProgressIndicator(),
    ):WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
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
            // backgroundColor: Colors.brown[50],
            body: Container(
              height:height,
              width: width,
              decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),fit: BoxFit.fill
              )),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Column(
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
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Text("🏆",style: TextStyle(color: Color(0xffffdf00),
                                                fontSize: 18,fontWeight: FontWeight.w600),),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Prize: ",
                                                    style: TextStyle(color: Color(0xffffdf00),
                                                        fontSize: 15,fontWeight: FontWeight.w600),
                                                  ),
                                                  Text(" ₹0.0",style: TextStyle(color: Colors.white,
                                                      fontSize: 15,fontWeight: FontWeight.w600))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    SizedBox(height: height*0.05,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        map==null?Container(
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
                                                child: Center(child: Icon(Icons.person, color: Colors.grey, size: 35,))),
                                            title: Text("Guest",
                                              style: TextStyle(color: Colors.black,fontSize: 15),),
                                            subtitle: Text('kkbk',
                                              style: TextStyle(color: Colors.black,fontSize: 15),),
                                          ),
                                        ):
                                        Container(
                                          height: height*0.1,
                                          width: width*0.4,
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
                                                child: Center(child: Image.network(Apiconst.Imageurl+map["image"],fit: BoxFit.fill,))),
                                            title: Text(map['fullname']==null?'':map['fullname'].toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                            subtitle: Text('kkbk',style: TextStyle(color: Colors.white,fontSize: 15),),
                                          ),
                                        ),


                                        Container(
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
                                                child: Center(child: Icon(Icons.person, color: Colors.grey, size: 35,))),
                                            title: Text("Guest",
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                            subtitle: Text('kkbk',
                                              style: TextStyle(color: Colors.white,fontSize: 15),),
                                          ),
                                        ),
                                        // FlatButton(
                                        //    shape: roundButtonShape,
                                        //    onPressed: () {
                                        //      //inverse the bot color and save it
                                        //      _chessController.botColor =
                                        //          chess_sub.Color.flip(
                                        //              _chessController.botColor);
                                        //      //save value int to prefs
                                        //      prefs.setInt('bot_color',
                                        //          _chessController.botColor.value);
                                        //      //set state, update the views
                                        //      setState(() {});
                                        //      //make move if needed
                                        //      _chessController.makeBotMoveIfRequired();
                                        //    },
                                        //    child:
                                        //    Text(
                                        //        (_chessController.botColor ==
                                        //                chess_sub.Color.WHITE)
                                        //            ? strings.white
                                        //            : strings.black,
                                        //        style:
                                        //            Theme.of(context).textTheme.button,
                                        //    ),
                                        //  ),
                                        //  SizedBox(
                                        //    width: 8,
                                        //  ),
                                        //  LiteRollingSwitch(
                                        //    value: (prefs?.getBool("bot") ?? true),//false
                                        //    onChanged: (pos) {
                                        //      prefs.setBool("bot", pos);
                                        //      //make move if needed
                                        //      _chessController?.makeBotMoveIfRequired();
                                        //    },
                                        //    // iconOn: Icons.done,
                                        //    // iconOff: Icons.close,
                                        //    // textOff: strings.bot_off,
                                        //    // textOn: strings.bot_on,
                                        //    colorOff: Colors.black,
                                        //    colorOn: Colors.black,
                                        //  ),
                                      ],
                                    ),
                                  ],
                                )
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       SelectableText(
                            //         currentGameCode,
                            //         style: Theme.of(context).textTheme.subtitle2,
                            //       ),
                            //       Text(
                            //           strings.turn_of_x(
                            //               (_chessController?.game?.game?.turn ==
                            //                   chess_sub.Color.BLACK)
                            //                   ? strings.black
                            //                   : strings.white),
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .subtitle1
                            //               .copyWith(
                            //             inherit: true,
                            //             color: (_chessController?.game
                            //                 ?.in_check() ??
                            //                 false)
                            //                 ? ((_chessController.game
                            //                 .inCheckmate(
                            //                 _chessController.game
                            //                     .moveCountIsZero()))
                            //                 ? Colors.purple
                            //                 : Colors.red)
                            //                 : Colors.black,
                            //           )),
                            //     ],
                            //   ),
                            // ),
                            Center(
                              // Center is a layout widget. It takes a single child and positions it
                              // in the middle of the parent.
                              child: SafeArea(
                                child: ChessBoard(
                                  boardType: boardTypeFromString(
                                      prefs.getString('board_style') ?? 'd'),
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
                  // GestureDetector(
                  //   onTap: () {
                  //     collapseFancyOptions = true;
                  //     setState(() {});
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: MediaQuery.of(context).size.height,
                  //     child: Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: SingleChildScrollView(
                  //               scrollDirection: Axis.horizontal,
                  //               child: Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 crossAxisAlignment: CrossAxisAlignment.end,
                  //                 children: [
                  //                   FancyOptions(
                  //                     up: true,
                  //                     rootIcon: Icons.online_prediction,
                  //                     rootText: strings.online_game_options,
                  //                     children: [
                  //                       FancyButton(
                  //                         onPressed: _onJoinCode,
                  //                         text: strings.join_code,
                  //                         icon: Icons.transit_enterexit,
                  //                         animation: FancyButtonAnimation.pulse,
                  //                       ),
                  //                       FancyButton(
                  //                         onPressed: _onCreateCode,
                  //                         text: strings.create_code,
                  //                         icon: Icons.add,
                  //                         animation: FancyButtonAnimation.pulse,
                  //                       ),
                  //                       FancyButton(
                  //                         text: strings.leave_online_game,
                  //                         animation: FancyButtonAnimation.pulse,
                  //                         icon: Icons.exit_to_app,
                  //                         visible: inOnlineGame,
                  //                         onPressed: _onLeaveOnlineGame,
                  //                       ),
                  //                     ],
                  //                   ),
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )

          ),
        ),
      ),
    );
  }
  var map;
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
    }
  }
}
