
import 'package:chess_bot/wholeproject/More/constapi.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';



class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
           onPressed: () {
             Navigator.pop(context);
             },
          icon: Icon(Icons.arrow_back,)),
        backgroundColor: primaryColor,
        title: Text("Privacy Policy"),
        centerTitle: true,
      ),
      body:privacy==null?Center(
        child: CircularProgressIndicator(),
      ):ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
                privacy==null?Center(
                  child: CircularProgressIndicator(),
                ):
                privacy.toString()
            ),
          ),
        ],
      ),
    ));
  }
}
