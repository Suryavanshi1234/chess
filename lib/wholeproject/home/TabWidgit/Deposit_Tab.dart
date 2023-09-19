import 'dart:convert';
import 'dart:ui';


import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class Deposit_History extends StatefulWidget {
  const Deposit_History({Key key}) : super(key: key);

  @override
  State<Deposit_History> createState() => _Deposit_HistoryState();
}

class _Deposit_HistoryState extends State<Deposit_History> {
  @override
  void dispose() {
    deposit_history;
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<List<deposit_history>>(
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
                "No Deposit History",
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
                      color: snapshot.data[index].status=='0'?Colors.red:
                      snapshot.data[index].status=='1'?Colors.orangeAccent:Colors.green,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                            blurRadius: 3,
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
                                  Text(
                                    "Deposit",
                                    style: TextStyle(
                                        fontFeatures: [
                                          FontFeature.superscripts()
                                        ],
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                      // "24/03/2002",
                                      "${snapshot.data[index].datetime}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15)),
                                  Text(
                                    "Date",
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
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(snapshot.data[index].status=='0'?'Failed':
                          snapshot.data[index].status=='0'?'Pending':"Success",
                                      style: TextStyle(
                                          color: snapshot.data[index].status=='0'?Colors.red:
                                          snapshot.data[index].status=="1"?Colors.orangeAccent:Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15)),
                                  Text(
                                    "Status",
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
    );
  }
  Future<List<deposit_history>> acd() async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");

    print('gkgotkhoktoh');

    final response = await http.get(
      Uri.parse(Apiconst.deposit_history+"id=$userid"),
    );
    print(response);
    print("😂😂😂😂😂");
    var jsond = json.decode(response.body)["data"];
    print('wwwwwwwwwwwwwwwwwwww');
    print(jsond);
    List<deposit_history> allround = [];
    for (var o in jsond)  {
    deposit_history al = deposit_history(
        o["amount"],
        o["date"],
        // o["date"]+' '+o['time'],
        o["discription"],
        o["id"],
        o["status"],
        o["userid"],


      );

      allround.add(al);
    }
    return allround;
  }
}
class deposit_history {
  String amount;
  String datetime;
  String discription;
  String id;
  String status;
  String userid;





  deposit_history(
      this.amount,
      this.datetime,
      this.discription,
      this.id,
      this.status,
      this.userid,

      );

}