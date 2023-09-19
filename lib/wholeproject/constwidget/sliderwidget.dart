import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chess_bot/gamechanger/PlayWithOnline.dart';
import 'package:chess_bot/main.dart';
import 'package:chess_bot/wholeproject/home/contestent.dart';
import 'package:chess_bot/wholeproject/home/freeplaycontestent.dart';
import 'package:chess_bot/wholeproject/slidermodel.dart';


import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class BannerWidget extends StatefulWidget {
  final String type;
  const BannerWidget({ this.type}) ;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget>
    with TickerProviderStateMixin {
  TextEditingController field = TextEditingController();
  TextEditingController JoinRoom = TextEditingController();
  String pasteValue = '';
  List<HomeBannerModel> bannerlist = [];
  bool isLoading = false;

  @override
  void initState() {
    // Create_Room_Referral();
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(Apiconst.Level+widget.type));
      if (response.statusCode == 200) {
        print("aaaaaa");
        final jsonData = json.decode(response.body)["data"] as List<dynamic>;
        setState(() {
          bannerlist =
              jsonData.map((item) => HomeBannerModel.fromJson(item)).toList();
        });
        print(jsonData);
        print('bbbbbbbbbbbbbbbbbbbbb');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    TabController _tabContrller = TabController(length: 2, vsync: this);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(alignment: Alignment.center,
        height: height * 0.5,
        width: width*0.9,
        child: CarouselSlider(

          items: bannerlist.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  height: height * 1,
                  width: width * 0.99,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                       image: DecorationImage(
                           image: NetworkImage(Apiconst.Imageurl+i.image), fit: BoxFit.fill),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: height * 0.08,
                        ),
                        Column(
                          children: [
                            Text("Level  "+i.id,
                              style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 100),
                              child: Row(
                                children: [
                                  Text(
                                    "Prize :"+i.prize,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        color: Colors.white),
                                  ),
                                  // Text("₹"+map["100"],style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
                                  const Image(image: AssetImage("assets/images/coin.png",),height: 70,),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Play Online: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                const Text(
                                  "♟️",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Prize :"+i.entryfee,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800)),
                                // Text("₹"+map["50"],style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            InkWell(
                                onTap: () {
                                  Invite_Room(levelid:i.id);

                                },
                                child: Card(shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),),
                                  color: Colors.transparent,
                                  elevation: 4,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.4,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.yellow),
                                        color: Colors.green,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50))),
                                    child: const Text(
                                      "Create Room",
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                );
              },
            );
            // $i'
          }).toList(),
          options: CarouselOptions(
            height: height * 1,
            aspectRatio: 12 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),

        ));

  }

  Invite_Room({ String levelid}  )async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response=await http.post(
      Uri.parse(Apiconst.Create_Room),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": userid,
        "levelid":levelid,
      }),
    );
    final data=jsonDecode(response.body);
    if(data["error"]=='200'){
      print("😂😂😂😂😂😂😂😂😂😂");
      print(levelid);
       final creatdata= data['invite'];

      print(creatdata);
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> free_contestent(creatdata:creatdata)));
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

  Join_Room(String JoinRoom,  { String level}  )async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response=await http.post(
      Uri.parse(Apiconst.Joine),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": userid,
        "levelid":level,
        "joined":JoinRoom,
      }),
    );
    final data=jsonDecode(response.body);
    if(data["error"]=='200'){
      print("😂😂😂😂😂😂😂😂😂😂");
      print(level);

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //              PlayWithFriends()));
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


  var map;
  Create_Room_Referral(String level) async {
     print('mapinvite');
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
     final Levelid=level.toString();
     final uri =Apiconst.Join_Room;

     // final uri =Uri.parse("https://apponrent.co.in/chess/api/crrget.php?userid=7&&levelid=2");
    print(uri);
    print('uri');
    final response = await http.post(Uri.parse(uri),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": userid,
        "levelid":level,

      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data["error"] == '200') {
      setState(() {
        map =data['data'];
        print(map['invite']);
        print('ram');
      });
    }
  }

}
