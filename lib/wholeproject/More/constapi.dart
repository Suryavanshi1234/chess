import 'dart:convert';

import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
var termcondition;
var aboutus;
var privacy;
var telegram;
var whatasapp;
var youtube;
var mobile;
var email;


class SupportApi{
  static  void fetchlauncherdata() async{

    final url= Uri.parse(Apiconst.Termscondition);
    final response = await http.get(
      url,
    );
    if (response.statusCode ==200){
      final responseData = json.decode(response.body)['data'];
      termcondition= responseData['termscondition'];
      aboutus =responseData['aboutus'];
      privacy=responseData['privacypolicy'];
      print(responseData);
      print("🏆🏆🏆🏆🏆🏆🏆");

    }
    else{
      throw Exception("Failed to fetch notification");
    }
  }
  static void fetchdata() async{

    final url= Uri.parse(Apiconst.Link);
    final response = await http.get(
      url,
    );
    if (response.statusCode ==200){
      final responseData = json.decode(response.body)['data'];
      telegram= responseData['telegram'];
      whatasapp =responseData['whatasapp'];
      youtube=responseData['youtube'];
      mobile=responseData['mobile'];
      email=responseData['email'];
      print(responseData);
      print("😢😢😢😢😢😢");

    }
    else{
      throw Exception("Failed to fetch notification");
    }
  }
}
