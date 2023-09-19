import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:chess_bot/gamechanger/PlayWithOnline.dart';
import 'package:chess_bot/main.dart';
import 'package:chess_bot/wholeproject/home/contestent.dart';
import 'package:chess_bot/wholeproject/slidermodel.dart';
import 'package:chess_bot/wholeproject/webview_freeplay.dart';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class Unlimited_Slider_page extends StatefulWidget {
  final String type;
  const Unlimited_Slider_page({this.type}) ;

  @override
  State<Unlimited_Slider_page> createState() => _Unlimited_Slider_pageState();
}

class _Unlimited_Slider_pageState extends State<Unlimited_Slider_page>
    with TickerProviderStateMixin {
  TextEditingController field = TextEditingController();
  TextEditingController JoinRoom = TextEditingController();
  String pasteValue = '';
  List<HomeBannerModel> bannerlist = [];
  bool isLoading = false;

  @override
  void initState() {
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
                         image: NetworkImage(Apiconst.Imageurl+i.image), fit: BoxFit.fill
                          // image: AssetImage("assets/images/Container.jpg")
                      ),
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
                              style: TextStyle(
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        color: Colors.white),
                                  ),
                                  // Text("₹"+map["100"],style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
                                  Image(image: AssetImage("assets/images/coin.png",),height: 70,),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Play Online: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                Text(
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
                                Text("Entry Fee: "+i.entryfee,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800)),
                                // Text("₹"+map["50"],style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            // SizedBox(height: 15,),
                            InkWell(onTap: (){
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => WebViewExample(
                              //             url:
                              //             "https://onlinechess.apponrent.co.in/",
                              //           )));
                              // // PlayOnlline_Join( level:i.id, );
                              PlayOnlline_Join(level:i.id,entryfee:i.entryfee);
                            },
                              child: Container(alignment:Alignment.center,
                                width: width*0.3,
                                height: height*0.05,

                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/btn_sure.png"),fit: BoxFit.fill),
                                ),
                                child: Text("Join",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
                              ),
                              // Create_Room_Referral(level: i.id),
                            )],
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
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),

        ));

  }
// PlayOnlline_Join({String level}  )async{
//   print("👍👍👍👍👍👍👍👍👍👍");
//   final prefs = await SharedPreferences.getInstance();
//   final userid=prefs.getString("userId");
//   final response=await http.post(
//     Uri.parse(Apiconst.Online_Play_Join),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       "userid": userid,
//       "levelid":level,
//     }),
//   );
//   final data=jsonDecode(response.body);
//   if(data["error"]=='200'){
//     print("😂😂😂😂😂😂😂😂😂😂");
//     print(level);
//
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 PlayWithOnline()));
//   }else{
//
//     Fluttertoast.showToast(
//         msg: data['msg'],
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
//   }
//   print(data);
// }
  PlayOnlline_Join({String level, String entryfee}  )async{
    print("👍👍👍👍👍👍👍👍👍👍");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response=await http.get(
      Uri.parse(Apiconst.Joine+"userid=$userid&levelid=$level"),
    );
    final data=jsonDecode(response.body);
    if(data["error"]=='200'){
      print("😂😂😂😂😂😂😂😂😂😂");
      print(level);

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
