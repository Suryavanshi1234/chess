//
// import 'package:chess_bot/main.dart';
// import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';
//
//
// class MyRoutes{
//
//   static final FluroRouter router = FluroRouter();
//
//   static Handler home = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) => MyHomePage(
//           id: params["id"][0],
//         oid:params["oid"][0],
//         type:params["type"][0],
//         roomcode:params["roomcode"][0],
//         // id: "19",
//         // oid:"0",
//         // type:"2",
//         // roomcode:"eijdk",
//       ));
//   // static Handler _catRepo = Handler(
//   //     handlerFunc: (BuildContext context, Map<String, dynamic> params) => Home());
//   // static Handler _Detailpage = Handler(
//   //     handlerFunc: (BuildContext? context, Map<String, dynamic> params) => OnTap
//   //       (id: params['id'][0], product_name: params['product_name'][0],
//   //       product_category: params['product_category'][0],)
//   // );
//
//
//   static void setupRouter() {
//     // router.define(
//     //   '/',
//     //   handler: _catRepo,
//     // );
//     // router.define(
//     //   '/category/:id/:name',
//     //
//     //   handler: _catRepo,
//     // );
//     router.define(
//       '/MyHomePage/:id/:oid/:type/:roomcode',
//
//       handler: home,
//     );
//
//   }
//
// }