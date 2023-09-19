import 'package:chess_bot/wholeproject/constant.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';



class Refer_Earn extends StatefulWidget {
  final onrefer;
  const Refer_Earn({Key key , this.onrefer}) : super(key: key);

  @override
  State<Refer_Earn> createState() => _Refer_EarnState();
}

class _Refer_EarnState extends State<Refer_Earn> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      appBar: AppBar(backgroundColor: primaryColor,elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Referral Program"),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment:MainAxisAlignment.start,

        children: [
          Container (
            height: height*0.4,
            width: width*1,
            decoration: BoxDecoration( borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
                image: DecorationImage(image:AssetImage("assets/images/refer-removebg-preview.png"),)
                ,color: primaryColor),
          ),
          SizedBox(height: 15,),
          Text("SHARE AND EARN MORE!",
            style: TextStyle(
                color: primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25,0,15,0),
            child: Text( "Invite your friend to play our app and yoou'll get 1% of the joining fees everytime your referred user join"
                " a paid contest above ₹50.This will be added to your bonus balance so,you use it to jooin any contest.",
              style: TextStyle(color: Colors.black.withOpacity(0.5),
              fontSize: 15)
            ),
          ),
          SizedBox(height: 20,),
          DottedBorder(
            color: Colors.black,
            strokeWidth: 2,
            radius: Radius.circular(12),
            dashPattern: [
              5,
              5,
            ],
            child: Container(alignment: Alignment.center,
              height: 40,
              width: 200,
              color: Colors.black.withOpacity(0.2),
              child: Text(widget.onrefer["ownref"]==null?"":widget.onrefer["ownref"]==""?"":
                widget.onrefer["ownref"],
                style: TextStyle(color:Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.w500, ),
              ),

              ),
            ),
          SizedBox(height: 30,),

          Card(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),),
            child: Container(
              height: height*0.05,
              width: width*0.5,
              decoration: BoxDecoration( border: Border.all(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(20)),),
              child: InkWell(
                onTap: (){
                  Share.share(widget.onrefer["ownref"],);
                },
                child: Row(
                  children: [
                    CircleAvatar(radius: 20,backgroundColor: Colors.blue,
                        child: Icon(Icons.share,color: Colors.white,)),
                    SizedBox(width: 5,),
                    Text("Share the code",style:TextStyle(color: primaryColor,fontSize: 18,
                        fontWeight: FontWeight.w700,))
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    )) ;
  }
}
