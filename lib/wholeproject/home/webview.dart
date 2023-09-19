import 'dart:async';
import 'dart:io';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Payurl extends StatefulWidget {
  final String url;
  // final String? name;
  Payurl({this.url});
  @override
  PayurlState createState() => PayurlState();
}

class PayurlState extends State<Payurl> {

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){},icon: Icon(Icons.arrow_back,color: Colors.white,),),
      ),
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
      // floatingActionButton: favoriteButton(),
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
              Navigator.pop(context);
            },
            label: Text("Go to Lobby"),
            icon: const Icon(Icons.arrow_back_ios),
          );
        });
  }
}