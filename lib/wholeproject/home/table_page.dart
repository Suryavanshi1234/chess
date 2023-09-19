import 'package:carousel_slider/carousel_slider.dart';
import 'package:chess_bot/wholeproject/Dashboard/More.dart';
import 'package:chess_bot/wholeproject/constwidget/onlline_slider.dart';
import 'package:chess_bot/wholeproject/constwidget/unlimited_slider.dart';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';





class Table_Page extends StatefulWidget {
  final String type;
  const Table_Page({ this.type, });

  @override
  State<Table_Page> createState() => _Table_PageState();
}

class _Table_PageState extends State<Table_Page> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc19272),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Details()));
                },
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ))
          ],
      ),
      body: Container(
        height: double.infinity,
        width: width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/BackGround.png"),fit: BoxFit.fill,)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CarouselSlider(
            //   options: CarouselOptions(
            //     height: height*0.5,
            //     aspectRatio: 16/9,
            //     viewportFraction: 0.8,
            //     initialPage: 0,
            //     enableInfiniteScroll: true,
            //     reverse: false,
            //     autoPlay: false,
            //   //  autoPlayInterval: Duration(seconds: 3),
            //    // autoPlayAnimationDuration: Duration(milliseconds: 800),
            //    // autoPlayCurve: Curves.fastOutSlowIn,
            //     enlargeCenterPage: true,
            //     enlargeFactor: 0.3,
            //     // onPageChanged: callbackFunction,
            //     scrollDirection: Axis.horizontal,
            //   ),
            //   items: [
            //     Container(alignment: Alignment.center,
            //         decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Container.jpg"),fit: BoxFit.fill),
            //         ),
            //       child: ListView(shrinkWrap: true,
            //         children: [SizedBox(height: 55,),
            //           Column(
            //             children: [
            //               Text("Level 1",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900,color: Colors.white),),
            //               SizedBox(height: 30,),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 55
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Text("Prize: ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white),),
            //                     Text("₹100",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
            //                     Image(image: AssetImage("assets/images/coin.png",),height: 70,),
            //                   ],
            //                 ),
            //               ),SizedBox(height: 18,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Play Online: ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.white),),
            //                   Text("♟️",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.white),),
            //                 ],
            //               ),
            //               SizedBox(height: 20,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Entry Fee:  ",style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800)),
            //                   Text("₹50",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ],
            //               ),
            //               SizedBox(height: 15,),
            //               InkWell(onTap: (){
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainMenuView())));
            //               },
            //                 child: Container(alignment:Alignment.center,
            //                   width: width*0.3,
            //                   height: height*0.05,
            //                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/btn_sure.png"),fit: BoxFit.fill),
            //                 ),
            //                   child: Text("Join",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ),
            //               )
            //             ],
            //
            //           ),
            //         ],
            //       ),
            //
            //     ),
            //     Container(alignment: Alignment.center,
            //       decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Container2.jpg"),fit: BoxFit.fill),
            //       ),
            //       child: ListView(shrinkWrap: true,
            //         children: [SizedBox(height: 55,),
            //           Column(
            //             children: [
            //               Text("Level 2",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900,color: Colors.white),),
            //               SizedBox(height: 30,),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 55
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Text("Prize: ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white),),
            //                     Text("₹200",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
            //                     Image(image: AssetImage("assets/images/coin.png",),height: 70,),
            //                   ],
            //                 ),
            //               ),SizedBox(height: 18,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Play Online: ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.white),),
            //                   Text("♟️",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.white),),
            //                 ],
            //               ),
            //               SizedBox(height: 20,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Entry Fee:  ",style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800)),
            //                   Text("₹100",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ],
            //               ),
            //               SizedBox(height: 15,),
            //               InkWell(onTap: (){
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainMenuView())));
            //               },
            //                 child: Container(alignment:Alignment.center,
            //                   width: width*0.3,
            //                   height: height*0.05,
            //                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/btn_sure.png"),fit: BoxFit.fill),
            //                   ),
            //                   child: Text("Join",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ),
            //               )
            //             ],
            //
            //           ),
            //         ],
            //       ),
            //
            //     ),
            //     Container(alignment: Alignment.center,
            //       decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Container3.jpg"),fit: BoxFit.fill),
            //       ),
            //       child: ListView(shrinkWrap: true,
            //         children: [SizedBox(height: 55,),
            //           Column(
            //             children: [
            //               Text("Level 3",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900,color: Colors.white),),
            //               SizedBox(height: 30,),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 55
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Text("Prize: ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white),),
            //                     Text("₹300",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
            //                     Image(image: AssetImage("assets/images/coin.png",),height: 70,),
            //                   ],
            //                 ),
            //               ),SizedBox(height: 18,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Play Online: ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.white),),
            //                   Text("♟️",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.white),),
            //                 ],
            //               ),
            //               SizedBox(height: 20,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Entry Fee:  ",style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800)),
            //                   Text("₹150",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ],
            //               ),
            //               SizedBox(height: 15,),
            //               InkWell(onTap: (){
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainMenuView())));
            //               },
            //                 child: Container(alignment:Alignment.center,
            //                   width: width*0.3,
            //                   height: height*0.05,
            //                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/btn_sure.png"),fit: BoxFit.fill),
            //                   ),
            //                   child: Text("Join",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ),
            //               )
            //             ],
            //
            //           ),
            //         ],
            //       ),
            //
            //     ),
            //     Container(alignment: Alignment.center,
            //       decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Container4.jpg"),fit: BoxFit.fill),
            //       ),
            //       child: ListView(shrinkWrap: true,
            //         children: [SizedBox(height: 55,),
            //           Column(
            //             children: [
            //               Text("Level 4",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900,color: Colors.white),),
            //               SizedBox(height: 30,),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 55
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Text("Prize: ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white),),
            //                     Text("₹400",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
            //                     Image(image: AssetImage("assets/images/coin.png",),height: 70,),
            //                   ],
            //                 ),
            //               ),SizedBox(height: 18,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Play Online: ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.white),),
            //                   Text("♟️",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.white),),
            //                 ],
            //               ),
            //               SizedBox(height: 20,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Entry Fee:  ",style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800)),
            //                   Text("₹200",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ],
            //               ),
            //               SizedBox(height: 15,),
            //               InkWell(onTap: (){
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainMenuView())));
            //               },
            //                 child: Container(alignment:Alignment.center,
            //                   width: width*0.3,
            //                   height: height*0.05,
            //                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/btn_sure.png"),fit: BoxFit.fill),
            //                   ),
            //                   child: Text("Join",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ),
            //               )
            //             ],
            //
            //           ),
            //         ],
            //       ),
            //
            //     ),
            //     Container(alignment: Alignment.center,
            //       decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Container5.jpg"),fit: BoxFit.fill),
            //       ),
            //       child: ListView(shrinkWrap: true,
            //         children: [SizedBox(height: 55,),
            //           Column(
            //             children: [
            //               Text("Level 5",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900,color: Colors.white),),
            //               SizedBox(height: 30,),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 55
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Text("Prize: ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white),),
            //                     Text("₹500",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
            //                     Image(image: AssetImage("assets/images/coin.png",),height: 70,),
            //                   ],
            //                 ),
            //               ),SizedBox(height: 18,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Play Online: ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.white),),
            //                   Text("♟️",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.white),),
            //                 ],
            //               ),
            //               SizedBox(height: 20,),
            //               Row(mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text("Entry Fee:  ",style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800)),
            //                   Text("₹250",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ],
            //               ),
            //               SizedBox(height: 15,),
            //               InkWell(onTap: (){
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainMenuView())));
            //               },
            //                 child: Container(alignment:Alignment.center,
            //                   width: width*0.3,
            //                   height: height*0.05,
            //                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/btn_sure.png"),fit: BoxFit.fill),
            //                   ),
            //                   child: Text("Join",style:TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w900)),
            //                 ),
            //               )
            //             ],
            //
            //           ),
            //         ],
            //       ),
            //
            //     ),
            //   // ].map((i) {
            //   //   return Builder(
            //   //     builder: (BuildContext context) {
            //   //       return
            //   //         Container(
            //   //
            //   //           width: MediaQuery.of(context).size.width,
            //   //           margin: EdgeInsets.symmetric(horizontal: 5.0),
            //   //           decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/Container.jpg"),fit: BoxFit.fill),
            //   //           ),
            //   //           child: Column(
            //   //             children: [
            //   //               Text('text $i', style: TextStyle(fontSize: 16.0),),
            //   //             ],
            //   //           )
            //   //       );
            //   //     },
            //   //   );
            //   // }).toList(),
            //     ]
            // ),
            //  Online_Slider()
            Unlimited_Slider_page(type:widget.type)

          ],
        ),
      ),
    );
  }
}
