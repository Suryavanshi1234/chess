import 'dart:ui';

import 'package:chess_bot/main.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';




class FirstTabPage extends StatefulWidget {
  const FirstTabPage({Key key}) : super(key: key);

  @override
  State<FirstTabPage> createState() => _FirstTabPageState();
}

class _FirstTabPageState extends State<FirstTabPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height*0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Color(0xfffe4d6a),
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
                  child: ListTile(
                    title: Text(
                      "Level 1",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Text("₹ 20",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                Text(
                                  "Win",
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
                                Text("₹ 10",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                Text(
                                  "Fee",
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
                            Text("₹ 20")
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            StepProgressIndicator(
                              totalSteps: 15,
                              currentStep: 6,
                              size: 5,
                              padding: 0,
                              selectedColor: Color(0xfffe4d6a),
                              unselectedColor: Colors.grey,
                              roundedEdges: Radius.circular(5),
                              fallbackLength: 200,
                            ),
                            Container(alignment: Alignment.center,
                              height: height*0.03,
                              width: width*0.2,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color:  Color(0xfffe4d6a)),
                              ),
                              child: InkWell(onTap:(){
                                showDialog(context: context, builder:
                                    (BuildContext context){
                                  return AlertDialog(
                                      scrollable: true,
                                      title: Row(
                                        children: [
                                          Image(image: AssetImage("assets/images/game.png")),
                                          SizedBox(width: 10,),
                                          Text("JOIN MATCH"),
                                        ],
                                      ),

                                      content:
                                    Text("Are you sure you want to join?"),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                      children: [
                                        TextButton(onPressed: () { Navigator.pop(context); },
                                            child: Text("CANCLE",style:
                                            TextStyle(fontSize: 15,color:Color(0xfffe4d6a) ),)),
                                        TextButton(
                                          // onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CreateTable())); },
                                          child: Text("CONFIRM",style: TextStyle(fontSize: 15,color: Color(0xfffe4d6a)
                                          ),),
                                        ),
                                      ],
                                    )],
                                  );
                                }
                                );
                              },
                                  child: Text("Join",style: TextStyle(fontSize: 16),)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
