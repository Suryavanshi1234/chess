import 'dart:convert';
import 'dart:ui';


import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class Withdrawl_History extends StatefulWidget {
  const Withdrawl_History({Key key}) : super(key: key);

  @override
  State<Withdrawl_History> createState() => _Withdrawl_HistoryState();
}

class _Withdrawl_HistoryState extends State<Withdrawl_History> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<List<withdraw>>(
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
                          image: AssetImage("assets/images/NO_Data.png"),
                        )
                    ),
                  ),
                  Text(
                    "No Withdrawal History",
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
                          color: snapshot.data[index].status=="0"?Colors.red:
                          snapshot.data[index].status=="1"?Colors.orangeAccent:Colors.green,
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text("₹ "+'${snapshot.data[index].amount}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 40)),
                                      Text(
                                        "Withdrawl",
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
                                      Text("25/7/23",
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Text("03:14")
                                ],
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text("${snapshot.data[index].mobile}",
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15)),
                                      Text(
                                        "Mobile",
                                        style: TextStyle(
                                            fontFeatures: [
                                              FontFeature.superscripts()
                                            ],
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      Text(snapshot.data[index].status=='0'?'Reject ':
                                      snapshot.data[index].status=='1'?'Pending ':'Success ',
                                          style: TextStyle(
                                              color: snapshot.data[index].status=='0'?Colors.red:
                                              snapshot.data[index].status=='1'?Colors.orangeAccent:Colors.green,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15)),
                                      Text(
                                        "status",
                                        style: TextStyle(
                                            fontFeatures: [
                                              FontFeature.superscripts()
                                            ],
                                            color: Colors.black,
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
    Future<List<withdraw>> acd() async{
      final prefs = await SharedPreferences.getInstance();
      final userid=prefs.getString("userId");
      print(userid);

    print('gkgotkhoktoh');
    final response = await http.get(
    Uri.parse(Apiconst.Withdrawal_History+"id=$userid"),
    );
    print(response);
    print("😂😂😂😂😂");
    var jsond = json.decode(response.body)["data"];
    print('wwwwwwwwwwwwwwwwwwww');
    print(jsond);
    List<withdraw> allround = [];
    for (var o in jsond)  {
    withdraw al = withdraw(
    o["amount"],
    o["datetime"],
    o["discription"],
    o["id"],
    o["mobile"],
    o["status"],
    o["tableid"],
    o["updatetime"],
    o["userid"],


    );

    allround.add(al);
    }
    return allround;
    }
}
  class withdraw {
  String amount;
  String datetime;
  String discription;
  String id;
  String mobile;
  String status;
  String tableid;
  String updatetime;
  String userid;





  withdraw(
  this.amount,
  this.datetime,
  this.discription,
  this.id,
  this.mobile,
  this.status,
  this.tableid,
  this.updatetime,
  this.userid,

  );

  }