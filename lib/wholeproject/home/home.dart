// import 'dart:ui';
//
// import 'package:chess_app/screen/Dashboard/More.dart';
// import 'package:flutter/material.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';
//
// import 'TabWidgit/tab_first.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     TabController _tabContrller = TabController(length: 2, vsync: this);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: Image.asset("assets/images/ChessLogo.png"),
//           title: Text(
//             "Realmoneychess",
//             style: TextStyle(
//                 color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
//           ),
//           backgroundColor: Color(0xfffe4d6a),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context)=>Details()));
//                 },
//                 icon: Icon(
//                   Icons.account_balance_wallet,
//                   color: Colors.white,
//                 ))
//           ],
//           bottom: TabBar(
//             controller: _tabContrller,
//             tabs: [
//               Tab(
//                 text: ("UPCOMING"),
//               ),
//               // Tab(
//               //   text: ("ONCOMING"),
//               // ),
//               Tab(
//                 text: ("COMPLETED"),
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(controller: _tabContrller, children: [
//           FirstTabPage(),
//            Text("No Ongoing Contest"),
//         ]),
//       ),
//     );
//   }
// }
