import 'package:chess_bot/wholeproject/More/constapi.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
var groupLink="https://t.me/realmoneychess";
class Launcher{
  static void openwhatsapp(context) async{
    final String whatsapp = whatasapp;
  //  var whatsapp ="+919565183872";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    // var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context ).showSnackBar(
          SnackBar(content: new Text("whatsapp not installed")));

    }
  }
  static void  openteligram() async {
    final String groupLink = "https://t.me/realmoneychess"; // Replace with your Telegram group link

    if (await canLaunch(groupLink)) {
      await launch(groupLink);
    } else {
      throw "Could not launch $groupLink";
    }
  }
  static void launchCaller() async {
    final String url = mobile;

    if (await canLaunch(url)) {
      await launch(url);
    } else    {
      throw 'Could not launch $url';
    }
  }
  static const String dialPadScheme = 'tel';
  static const String errorMessage = 'Could not launch dial pad';

  static Future<void> openDialPad() async {
    final Uri _phoneLaunchUri = Uri(
      scheme: dialPadScheme,
      path: mobile,
    );

    if (await canLaunch(_phoneLaunchUri.toString())) {
      await launch(_phoneLaunchUri.toString());
    } else {
      throw errorMessage;
    }
  }


  static void launchEmail() async {
    final String gmail = email;
    if (await canLaunch("mailto:$gmail")) {
      await launch("mailto:$gmail");
    } else {
      throw 'Could not launch';
    }
  }

  // static void  linkurl() async {
  //   const url = 'https://www.geeksforgeeks.org/';
  //   if (await canLaunch(url)) {
  //     await launch(url, forceWebView: true, enableJavaScript: true);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}