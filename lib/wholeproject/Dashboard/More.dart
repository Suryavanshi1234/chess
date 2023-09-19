import 'dart:convert';

// import 'package:chess_app/More/about_us.dart';
// import 'package:chess_app/More/depoosit_money.dart';
// import 'package:chess_app/More/history.dart';
// import 'package:chess_app/More/privacy.dart';
// import 'package:chess_app/More/terms&condition.dart';
// import 'package:chess_app/More/update_profile.dart';
// import 'package:chess_app/More/withdraw_money.dart';
// import 'package:chess_app/constant.dart';
// import 'package:chess_app/screen/Auth/login.dart';
import 'package:chess_bot/wholeproject/Auth/login.dart';
import 'package:chess_bot/wholeproject/More/about_us.dart';
import 'package:chess_bot/wholeproject/More/constapi.dart';
import 'package:chess_bot/wholeproject/More/depoosit_money.dart';
import 'package:chess_bot/wholeproject/More/game_history.dart';
import 'package:chess_bot/wholeproject/More/history.dart';
import 'package:chess_bot/wholeproject/More/privacy.dart';
import 'package:chess_bot/wholeproject/More/refer_earn.dart';
import 'package:chess_bot/wholeproject/More/support.dart';
import 'package:chess_bot/wholeproject/More/terms&condition.dart';
import 'package:chess_bot/wholeproject/More/update_profile.dart';
import 'package:chess_bot/wholeproject/More/withdraw_money.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class Details extends StatefulWidget {
  const Details({Key key}) : super(key: key);


  @override
  State<Details> createState() => _DetailsState();
}


class _DetailsState extends State<Details> {
  @override
  void initState() {
    viewprofile();
    SupportApi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Image.asset("assets/images/ChessLogo.png"),
        backgroundColor: primaryColor,
        title: Text(
          "Realmoneychess",
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        //   Icon(
        //     Icons.notifications_rounded,
        //     color: Colors.white,
        //   )
        // ],
      ),
      body: ListView(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.2,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        color: primaryColor),
                  ),
                ],
              ),
               map ==null? Center(
                  child: CircularProgressIndicator()):
                   withdrawll==null?Center(
                       child: CircularProgressIndicator()):
                       deposit==null?Center(
                           child: CircularProgressIndicator()):
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        map["image"]== null? CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/no-image-available.png",),):
                        CircleAvatar(radius:30,
                          backgroundImage: NetworkImage(
                              Apiconst.Imageurl+map["image"]),
                          backgroundColor: primarytextColor,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(map["fullname"]== null?"":
                              map["fullname"],style: TextStyle(color: primarytextColor,fontWeight: FontWeight.w500,fontSize: 20),),
                            Text('+91 '+map["mobile"]== null?'':
                              '+91 '+map["mobile"],style: TextStyle(color:primarytextColor,fontWeight: FontWeight.w500,fontSize: 20),),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: height*0.25,
                      width: width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(height: height*0.06,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("My Balannce",style: TextStyle(color: Colors.black,fontSize: 18),),
                                  Text(map["wallet"]==''?"₹0.0":
                                      map["wallet"]==null?"₹0.0":
                                      "₹"+map["wallet"],style: TextStyle(color: Colors.black,fontSize: 18)),
                                      // "₹"+double.parse(map["wallet"]).toStringAsFixed(2),style: TextStyle(color: Colors.black,fontSize: 18)),
                                ],
                              ),
                            ),
                          ),Divider(),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DepositPage()));
                                  },
                                    child: CircleAvatar(radius: 25,backgroundColor:Color(0xff8bc24a),
                                      child: Image.asset("assets/images/icons8-wallet-64.png",scale: 2,),),
                                  ),
                                  Text(deposit["deposit"]==null?"₹ 0.0":
                                      "₹"+deposit["deposit"]),
                                  Text("Deposit")
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WithdrawPage()));
                                  },
                                    child: CircleAvatar(radius: 25,backgroundColor:Color(0xfffb8b6b),
                                      child: Image.asset("assets/images/icons8-bank-64 (1).png",scale: 2,),),
                                  ),
                                  Text(withdrawll['withdrawal']==null?"₹ 0.0":
                                  "₹"+withdrawll['withdrawal']),
                                  Text("Withdraw Cash")
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(onTap: (){

                                  },
                                    child: CircleAvatar(radius: 25,backgroundColor:Color(0xff3fa7f9),
                                      child: Image.asset("assets/images/icons8-tag-64.png",scale: 3,),),
                                  ),
                                  Text(bonus['bonus']==null?"₹0.0":
                                  "₹"+bonus['bonus']),
                                  Text("Bonus Cash")
                                ],
                              ),
                            ],)
                        ],
                      ),
                    ),
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                         crossAxisSpacing: 4.0,
                         mainAxisSpacing: 1.0,
                      ),
                      // itemCount: 10,
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_Profile(
                                profile: map)));
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,
                                          backgroundImage: AssetImage('assets/images/profile.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),

                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>History()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    //color:categories[index].end,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(elevation:1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
                                          //set border radius more than 50% of height and width to make circle
                                        )
                                        ,
                                        child: CircleAvatar(
                                          radius:25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(radius: 12,

                                            backgroundImage: AssetImage('assets/images/histoory.png',),backgroundColor: Colors.white, ),
                                        ),
                                      ),

                                    ),
                                  ),
                                  Center(
                                    child: Text('History',style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  // title: name[index]
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>game_History(
                              )));
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,

                                          backgroundImage: AssetImage('assets/images/gamehistory.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text('Game History',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),

                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Privacy()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,

                                          backgroundImage: AssetImage('assets/images/Policy.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text('Privacy Poicy',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),

                        // Container(
                        //   child: InkWell(
                        //     onTap: (){
                        //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_Profile(
                        //       // )));
                        //       _launchEmail();
                        //     },
                        //     child: Column(
                        //       children: [
                        //         Container(
                        //           //color:categories[index].end,
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Card(elevation:1,
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(80),
                        //                 //set border radius more than 50% of height and width to make circle
                        //               )
                        //               ,
                        //               child: CircleAvatar(
                        //                 radius:25,
                        //                 backgroundColor: Colors.white,
                        //                 child: CircleAvatar(radius: 12,
                        //
                        //                   backgroundImage: AssetImage('assets/images/Help.png',),backgroundColor: Colors.white, ),
                        //               ),
                        //             ),
                        //
                        //           ),
                        //         ),
                        //         Center(
                        //           child: Text('Need Help',style: TextStyle(fontWeight: FontWeight.bold),),
                        //         ),
                        //         // title: name[index]
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>About_us()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,

                                          backgroundImage: AssetImage('assets/images/about_us.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text('About Us',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms_Condition()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,

                                          backgroundImage: AssetImage('assets/images/Terms&Condition.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text('T & C',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Support_Page(
                              )));
                              // Teligram();
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,

                                          backgroundImage: AssetImage('assets/images/icons8-support-24.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text('Support',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Refer_Earn( onrefer: map)));
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,

                                          backgroundImage: AssetImage('assets/images/icons8-cash-in-hand-48.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text('Refer & Earn',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: (){
                              showDialog(

                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.white,

                                    content:  Container(
                                      height: 200,

                                      child: Column(
                                        children: [

                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                      "assets/images/Logout2.png",

                                                    )
                                                )
                                            ),

                                          ),

                                          Text('Are you Sure?',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
                                          Spacer(),


                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: new BorderRadius.circular(10.0),

                                              ),

                                              primary: Colors.redAccent,
                                              elevation: 10,
                                              textStyle: TextStyle(fontWeight: FontWeight.bold)),
                                          child: Text('Cancle')),
                                      ElevatedButton(onPressed: () async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.remove('userId');

                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (BuildContext ctx) =>login()));
                                      },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:  BorderRadius.circular(10.0),
                                              ),
                                              primary: Colors.green,
                                              elevation: 10,
                                              textStyle: TextStyle(fontWeight: FontWeight.bold)),
                                          child: Text('Logout')),
                                    ],



                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  //color:categories[index].end,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(elevation:1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        //set border radius more than 50% of height and width to make circle
                                      )
                                      ,
                                      child: CircleAvatar(
                                        radius:25,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(radius: 12,

                                          backgroundImage: AssetImage('assets/images/Logout.png',),backgroundColor: Colors.white, ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                // title: name[index]
                              ],
                            ),
                          ),
                        ),
                      ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  var map;
  var withdrawll;
  var deposit;
  var bonus;
  viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.get(
      Uri.parse(Apiconst.profile+"id=$userid"),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data["error"] == '200') {
      setState(() {
        map =data['data'];
        withdrawll=data['withdrawal'];
        deposit=data['deposit'];
        bonus=data['bonus'];

      });
    }
  }
}
// String email="dometoapp@gmail.com";
// _launchEmail() async {
//   if (await canLaunch("mailto:$email")) {
//     await launch("mailto:$email");
//   } else {
//     throw 'Could not launch';
//   }
// }
// Teligram()async{
//   var url = Uri.parse("tg://t.me/9793168164");
//   if (await canLaunchUrl(url)) {
//   await launchUrl(url);
//   }
// }