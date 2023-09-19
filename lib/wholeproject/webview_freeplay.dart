import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart'as http;


class WebViewExample extends StatefulWidget {
  final String url;
  final String randomName;
  WebViewExample({this.url,this.randomName,  });
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  // final WebViewCookieManager cookieManager = WebViewCookieManager();

  // void clearCookies() async {
  //   await cookieManager.clearCookies();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   leading: IconButton(onPressed: (){},icon: Icon(Icons.arrow_back,color: Colors.white,),),
      // ),
      body:  WebView(
        initialUrl: '${widget.url}',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          webViewController.clearCache();
          final cookieManager = CookieManager();
          cookieManager.clearCookies();

        },
        onProgress: (int progress) {
          Colors.black;
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },

        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton.extended(
            backgroundColor:primaryColor,
            onPressed: () {
              winner();
              // Navigator.pop(context);
            },
            label: Text("Go to Lobby"),
            icon: const Icon(Icons.arrow_back_ios),
          );
        });
  }
  winner() async {


print("winnerrrrrrrrrrrrrrrrrrrrrrrrrr");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.get(

      Uri.parse("https://apponrent.co.in/chess/api/updatestatus.php?userid=$userid"),

    );
    var data = jsonDecode(response.body);
    print("mmmmmmmmmmmm");
    print(data);
    print("mmmmmmmmmmmm");
    if (data["error"] == '200') {
      print(data);
      print("data😂😂😂😂😂😂😂");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottom()));
      // Fluttertoast.showToast(
      //     msg: data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

    }else{
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}