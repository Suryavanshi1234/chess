
import 'package:chess_bot/wholeproject/More/constapi.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';


class Terms_Condition extends StatefulWidget {
  const Terms_Condition({Key key}) : super(key: key);

  @override
  State<Terms_Condition> createState() => _Terms_ConditionState();
}

class _Terms_ConditionState extends State<Terms_Condition> {
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
            title: Text("Terms & Conditions"),
            centerTitle: true,
          ),
          body:termcondition==null?Center(
              child: CircularProgressIndicator()):
          ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                      termcondition==null?Center(
                        child: CircularProgressIndicator(),
                      ):
                      termcondition.toString()
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
