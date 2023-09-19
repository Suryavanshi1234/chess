import 'dart:convert';

import 'package:chess_bot/gamechanger/PlayWithFriend.dart';
import 'package:chess_bot/gamechanger/PlayWithOnline.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:chess_bot/wholeproject/constwidget/sliderwidget.dart';
import 'package:chess_bot/wholeproject/home/P_Friend_tablePage.dart';
import 'package:chess_bot/wholeproject/home/freeplaycontestent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';



class Create_Join extends StatefulWidget {
  final String type;
  const Create_Join({ this.type}) ;

  @override
  State<Create_Join> createState() => _Create_JoinState();
}

class _Create_JoinState extends State<Create_Join> {
  TextEditingController JoinRoom = TextEditingController();
  @override

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(appBar: AppBar(elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,)),
        backgroundColor: primaryColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height:height*0.875,
                width: width,
                decoration: BoxDecoration(

                    image: DecorationImage(image: AssetImage("assets/images/background.jpg"),fit: BoxFit.fill,)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Play_Friend_Tablepage(type:widget.type)));

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Play_Friend_Tablepage()));
                    },
                      child: Container(
                        alignment: Alignment.center,
                        width: width * 0.4,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage
                          (image: AssetImage("assets/images/createRoom.jpg"),fit: BoxFit.fill)),
                        // child: const Text(
                        //   "Create Room",
                        //   style: TextStyle(
                        //       fontSize: 22, color: Colors.white),
                        // ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    InkWell(onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              scrollable: true,
                              content: Container(
                                  height: height * 0.35,
                                  width: width * 0.2,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: const AssetImage(
                                            "assets/images/Popup2.png"),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: height * 0.25,
                                        width: width * 0.6,
                                        child:  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween
                                          ,
                                          children: [
                                            const Text(
                                                "Enter Room Code",
                                                style: const TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize:
                                                    18,
                                                    fontWeight:
                                                    FontWeight
                                                        .w900)),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(
                                                  8.0),
                                              child:
                                              Container(
                                                alignment:
                                                Alignment
                                                    .center,
                                                width: width *
                                                    0.5,
                                                height:
                                                height *
                                                    0.07,
                                                decoration:
                                                BoxDecoration(
                                                  border: Border.all(
                                                      width:
                                                      5,
                                                      color: Colors
                                                          .yellow),
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      const Radius.circular(20)),
                                                ),
                                                child:
                                                TextField(style: TextStyle(color: Colors.white),
                                                  controller:JoinRoom,
                                                  cursorColor:
                                                  Colors
                                                      .white,
                                                  decoration:
                                                  const InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10,
                                                        0,
                                                        0,
                                                        0),
                                                    border: InputBorder
                                                        .none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height*0.04,
                                            ),
                                            InkWell(
                                              onTap: () {

                                                  Join_Room(JoinRoom.text);

                                                  // var i;
                                                  // Join_Room(JoinRoom.text, level:i.id, );

                                              },
                                              child:
                                              Container(
                                                alignment:
                                                Alignment
                                                    .center,
                                                height:
                                                height *
                                                    0.05,
                                                width: width *
                                                    0.27,
                                                decoration:
                                                const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/btn_sure.png"),
                                                      fit: BoxFit
                                                          .fill),
                                                ),
                                                child: Text("Join",style: TextStyle(color: Colors.white,fontSize: 20,
                                                fontWeight: FontWeight.w900),),

                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          });
                    },
                      child: Container(
                        alignment: Alignment.center,
                        width: width * 0.4,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage
                          (image: AssetImage("assets/images/JoinRoom.jpg"),fit: BoxFit.fill)),
                        // child: const Text(
                        //   "Joine Room",
                        //   style: TextStyle(
                        //       fontSize: 22, color: Colors.white),
                        // ),
                      ),
                    ),
                  ],

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  // String uuid;
  // String roomcode;
  // String opponent;


  Join_Room(String JoinRoom,   )async{
    print("😁😁😁😁😁");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response=await http.post(
      Uri.parse("https://apponrent.co.in/chess/api/joincreateroom.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": userid,
         // "levelid":level,
        "joined":JoinRoom,
      }),
    );
    final data=jsonDecode(response.body);
    if(data["error"]=='200'){
      print("😂😂😂😂😂😂😂😂😂😂");
      // print(level);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  free_contestent()));
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





