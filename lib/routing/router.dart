// import 'package:chess_bot/main.dart';
// import 'package:chess_bot/routing/String_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
//
// Route<dynamic> generateRoute(RouteSettings settings) {
//   final routingData = settings.name.getRoutingData;
//   switch (routingData.route) {
//   // routingData.route
//     case MyHomePage:
//       return _getPageRoute(MyHomePage(), settings);
//
//     default:
//       return _getPageRoute(MyHomePage(), settings);
//   }
// }
//
// PageRoute _getPageRoute(Widget child, RouteSettings settings) {
//   return _FadeRoute(child: child, routeName: settings.name);
// }
//
// class _FadeRoute extends PageRouteBuilder {
//   final Widget child;
//   final String routeName;
//   _FadeRoute({this.child, this.routeName})
//       : super(
//           settings: RouteSettings(name: routeName),
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               child,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//             opacity: animation,
//             child: child,
//           ),
//         );
// }
