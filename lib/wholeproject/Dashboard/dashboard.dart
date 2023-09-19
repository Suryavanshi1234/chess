
// import 'package:chess_app/screen/Dashboard/More.dart';
// import 'package:chess_app/screen/Dashboard/youtube.dart';
// import 'package:chess_app/screen/home/home1.dart';

import 'package:chess_bot/wholeproject/Dashboard/More.dart';
import 'package:chess_bot/wholeproject/Dashboard/youtube.dart';
import 'package:chess_bot/wholeproject/home/home1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../home/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../More/constapi.dart';

class bottom extends StatefulWidget {
  const bottom({Key key}) : super(key: key);

  @override
  State<bottom> createState() => _bottomState();
}

class _bottomState extends State<bottom> {
  final pages = [
    First_home_page(),
    Youtube(),
    Details(),
  ];

  int pageIndex = 0;

  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  WillPopScope buildMyNavBar(BuildContext context) {
    return WillPopScope(
          onWillPop: () async {
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // shadowColor: Colors.black,
                  title: Text('Are you sure?', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                  content: Text('Do you want to exit from App', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
            return shouldPop;
          },

      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 20,
                  )
                      : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                // Text('Home', style: TextStyle(fontSize: 10,
                //     color: Colors.white,fontWeight: FontWeight.bold
                // ),),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },

                  icon: pageIndex == 1
                      ? const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                    size: 20,
                  )
                      : const Icon(
                    Icons.play_circle_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                // Text('How to play', style: TextStyle(fontSize: 10,
                //     color: Colors.white,fontWeight: FontWeight.bold
                // ),),
              ],
            ),
            // Column(
            //   children: [
            //     IconButton(
            //       enableFeedback: false,
            //       onPressed: () {
            //         setState(() {
            //           pageIndex = 2;
            //         });
            //       },
            //       icon: pageIndex == 2
            //           ? const Icon(
            //         Icons.widgets_rounded,
            //         color: Colors.white,
            //         size: 35,
            //       )
            //           : Image.asset('assets/helpcenter_light.png',
            //         height: 35,width: 35,color: Colors.white,),
            //     ),
            //     Text('Support', style: TextStyle(fontFamily: "Windsor",
            //         color: Colors.white,fontWeight: FontWeight.bold
            //     ),),
            //   ],
            // ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: pageIndex == 2
                      ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,

                  )
                      : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                // Text('Profile', style: TextStyle(fontSize: 10,
                //     color: Colors.white,fontWeight: FontWeight.bold
                // ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
