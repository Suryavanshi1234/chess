import 'dart:convert';
import 'dart:ui';


import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class game_History extends StatefulWidget {
  const game_History({Key key}) : super(key: key);

  @override
  State<game_History> createState() => _game_HistoryState();
}

class _game_HistoryState extends State<game_History> {
  @override
  void dispose() {
    Game_History;
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,)),
          backgroundColor: primaryColor,
          title: Text("Game History"),
          centerTitle: true,),
        body: FutureBuilder<List<Game_History>>(
            future: acd(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 700,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/NO_Data.png'),
                            )
                        ),
                      ),
                      Text(
                        "No Game History",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),

                    ],
                  ),
                );
              }
              else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: snapshot.data[index].type.toLowerCase()=='credit'?Colors.green:Colors.red,
                              // snapshot.data[index].status=='1'?Colors.orangeAccent:Colors.green,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    // color: snapshot.data[index].type.toLowerCase()=='credit'?Colors.green:Colors.red,
                                     color: Colors.grey.withOpacity(0.2))
                                ]),
                          // color: Color(0xfffe4d6a),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: [
                                          Text("₹"+"${snapshot.data[index].amount}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 40)),
                                          // Text(
                                          //   "Deposit",
                                          //   style: TextStyle(
                                          //       fontFeatures: [
                                          //         FontFeature.superscripts()
                                          //       ],
                                          //       color: Colors.black,
                                          //       fontWeight: FontWeight.w500,
                                          //       fontSize: 12),
                                          // ),
                                        ],
                                      ),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: [
                                          Text("${snapshot.data[index].datetime}",
                                              // snapshot.data[index].status=='0'?'Pending':"Success",
                                              style: TextStyle(

                                                  color: Colors.black.withOpacity(0.7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15)),
                                          Text(
                                            "Date/Time",
                                            style: TextStyle(
                                                fontFeatures: [
                                                  FontFeature.superscripts()
                                                ],
                                                color: Colors.black.withOpacity(0.8),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: [
                                          Text(
                                            // "24/03/2002",
                                              "${snapshot.data[index].type}",
                                              style: TextStyle(
                                                  color: snapshot.data[index].type.toLowerCase()=='credit'?Colors.green.withOpacity(0.8):Colors.red.withOpacity(0.8),
                                                  // color: Colors.black.withOpacity(0.5),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15)),
                                          Text(
                                            "Type",
                                            style: TextStyle(
                                                fontFeatures: [
                                                  FontFeature.superscripts()
                                                ],
                                                color: Colors.black.withOpacity(0.8),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
  Future<List<Game_History>> acd() async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");

    print('gkgotkhoktoh');

    final response = await http.get(
       Uri.parse(Apiconst.Game_History+"userid=$userid&type="),
      // Uri.parse("https://apponrent.co.in/chess/api/game_history.php?userid=$userid&type=credit"),
    );
    print(response);
    print("😂😂😂😂😂");
    var jsond = json.decode(response.body)["data"];
    print('wwwwwwwwwwwwwwwwwwww');
    print(jsond);
    List<Game_History> allround = [];
    for (var o in jsond)  {
      Game_History al = Game_History(
        o["amount"],
        o["type"],
        o["discription"],
        o["id"],
        o["status"],
         o["datetime"],
        //  o["date"]+' '+o['time'],


      );

      allround.add(al);
    }
    return allround;
  }
}
class Game_History {
  String amount;
  String type;
  String discription;
  String id;
  String status;
  String datetime;





  Game_History(
      this.amount,
      this.type,
      this.discription,
      this.id,
      this.status,
      this.datetime,

      );

}