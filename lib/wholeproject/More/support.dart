import 'package:chess_bot/wholeproject/Dashboard/launcher.dart';
import 'package:chess_bot/wholeproject/More/constapi.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Support_Page extends StatefulWidget {
  const Support_Page({Key key}) : super(key: key);

  @override
  State<Support_Page> createState() => _Support_PageState();
}

class _Support_PageState extends State<Support_Page> {
  @override
  void initState() {
    SupportApi.fetchdata();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,)),
          backgroundColor: primaryColor,
          title: Text("Support"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  height: height*0.3,
                  width: width,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/support.png"))),
                ),
              ),
              Text("Customer Service",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900),),
              Text("I support to solve any ",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.4))),
              Text("issue that you face",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.4))),

              // CircleAvatar(
              //   radius: 25,
              //   backgroundColor: Colors.transparent,
              //   child: Image.asset("assets/images/call.png"),
              // ),
              SizedBox(height: height*0.15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      // Launcher.launchCaller();
                      Launcher.openDialPad();
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))) ,
                      child:CircleAvatar(
                        radius:28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 22,
                          child: Image.asset("assets/images/call.png"),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Launcher.launchEmail();

                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))) ,
                      child:CircleAvatar(
                        radius:28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 22,
                          child: Image.asset("assets/images/gmail.png"),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Launcher.openteligram();
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))) ,
                      child:CircleAvatar(
                        radius:28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 22,
                          child: Image.asset("assets/images/telegram.png"),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Launcher.openwhatsapp(context);
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))) ,
                      child:CircleAvatar(
                        radius:28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 22,
                          child: Image.asset("assets/images/whatsapp.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],

          ),
        ),
      ),
    );
  }
}
