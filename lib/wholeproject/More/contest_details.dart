import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';



class Contest_Details extends StatefulWidget {
  const Contest_Details({Key key}) : super(key: key);

  @override
  State<Contest_Details> createState() => _Contest_DetailsState();
}

class _Contest_DetailsState extends State<Contest_Details> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(bottomNavigationBar:InkWell(onTap: (){
      Flushbar(flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor: Colors.black.withOpacity(0.2),
        title:  "Hey User",
        titleColor: Colors.white,
        message:  "Match Join Sucessfully! ",
        duration:  Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.bounceIn,
        flushbarPosition: FlushbarPosition.BOTTOM,
      )..show(context);
      
    },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(alignment:Alignment.center,
          height: 40,
            width: 200,color: Colors.redAccent,
          child: Text("PLAY NOW",style: TextStyle(color: Colors.white,fontSize: 20),),

        ),
      ),
    ),
      appBar: AppBar(leading: Icon(Icons.arrow_back),
        backgroundColor: Color(0xfffe4d6a),
      title: Text("Contest Details",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("Board close in\n    02m:56s",style:
          TextStyle(color:Color(0xff99bf22) ,fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(elevation: 3,
            child: Container(height: 250,
              alignment: Alignment.center,
              width: 400,
              child:Column(
                children: [
                  Container(alignment: Alignment.center,
                    height: 30,width: 400,color: Color(0xffe51d3f),
                    child: Text("Table & Opponen Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                  ),
                  Container(height: 40,alignment: Alignment.center,
                    child: Text("Dream Chess Vs Player 2",style:TextStyle(color: Colors.black.withOpacity(0.4),
                        fontSize:16,fontWeight: FontWeight.w500 ) ,),
                  ),Divider(),
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage("assets/images/win.png")),
                        ),
                        Text("Win",style: TextStyle(color: Colors.black.withOpacity(0.4)),),
                        Padding(
                          padding: const EdgeInsets.only(left:200),
                          child: Text("₹15.0",style: TextStyle(color:Color(0xfffe4d6a),fontWeight: FontWeight.w500 ),),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage("assets/images/icons8-chess-50.png")),
                        ),
                        Text("Board Number",style: TextStyle(color: Colors.black.withOpacity(0.4))),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Text("#1",style: TextStyle(color:Color(0xfffe4d6a),fontWeight: FontWeight.w500 )),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage("assets/images/icons8-whatsapp-30.png")),
                        ),
                        Text("Contact opponent & Share\nRoomCode",style: TextStyle(color: Colors.black.withOpacity(0.4))),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text("Click Here",style: TextStyle(color:Color(0xfffe4d6a),fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 5),
            child: Text("Please,Don't press back until waiting time over or opponent join match.",
              style: TextStyle(color:Color(0xff99bf22) ,
                  fontSize: 16,fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 232,top: 15),
            child: Text("Rules & Policy", style: TextStyle(color:Colors.black ,
                fontSize: 16,fontWeight: FontWeight.w500)),
          )
      ],
      ),
      
    ));
  }
}
