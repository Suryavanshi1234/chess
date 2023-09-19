
import 'package:chess_bot/wholeproject/More/constapi.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';


class About_us extends StatefulWidget {
  const About_us({Key key}) : super(key: key);

  @override
  State<About_us> createState() => _About_usState();
}

class _About_usState extends State<About_us> {
  @override
  void initState() {
    SupportApi.fetchlauncherdata();
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
            title: Text("About Us"),
            centerTitle: true,
          ),
          body:aboutus==null?Center(
            child: CircularProgressIndicator(),
          ):ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                    aboutus==null?Center(
                      child: CircularProgressIndicator(),
                    ):
                    aboutus.toString()
                ),
              ),
            ],
          ),
        ));
  }
}
