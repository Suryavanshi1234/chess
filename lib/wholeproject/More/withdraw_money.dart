// importimport 'dart:convert';


import 'dart:convert';

import 'package:chess_bot/wholeproject/More/history.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;


class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {

  String payment;
  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController amount=TextEditingController();

  bool loading=false ;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(child: Scaffold(

      appBar: AppBar(leading: InkWell(onTap: (){
        Navigator.pop(context);
      },
          child: Icon(Icons.arrow_back)),
        title: Text("Withdraw Money",style: TextStyle(color:Colors.white,),),
        backgroundColor:primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height:55,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  buildRadioButton(0,'PayTm'),
                  buildRadioButton(1,"GooglePay"),
                  buildRadioButton(2,'PhonePe')
                ],
              ),
            ),
          ),
          buildTextField(width,height),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,15,8,15),
            child: Text("*Note: only winning amount can be withdraw and it will be\n          "
                " transferred to yoour wallet within 24 hours",
              style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
          ),
          InkWell(onTap: (){
            print("😂😂😂😂");
            final val= int.parse(amount.text);
            if(val >= 100){
              print("condition true");
              Deposit(name.text,number.text,amount.text);
            }
            else{
              Fluttertoast.showToast(
                  msg:"Must be fill amount more than Rs. 100",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          },
            child: Container(alignment: Alignment.center,
              height: height*0.07,width: width*0.8,
              //color: Colors.redAccent,
              decoration: BoxDecoration(borderRadius:
              BorderRadius.all(Radius.circular(30)),color: primaryColor),
              child: Text("WITHDRAW",style: TextStyle(fontWeight: FontWeight.w600,
                  fontSize: 20,color: Colors.white),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text("Minimum Redeem Amount is ₹100",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,
                color:primaryColor ),),
          )


        ],
      ),
    )
    );
  }
  int selectedRadio = 0;
  Widget buildRadioButton(int value, String label) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Radio(activeColor: primaryColor,
          value: value,
          groupValue: selectedRadio,
          onChanged: (int newValue) {
            setState(() {
              selectedRadio = newValue;
              print(selectedRadio);
            });
          },
        ),
        Text(label,style: TextStyle(fontSize: 12),),
      ],
    );
  }
  Widget buildTextField(width,heigth){
    return Column(
      children: [
        Container(
          width: width*0.9,height: heigth*0.07,
          decoration: BoxDecoration(border:Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)
            ),),
          child: TextField(
            controller: name,
              decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              border: InputBorder.none,hintText: "Enter Register Name",
              hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400))
          ),
        ),
        SizedBox(height: 10,),
       Padding(
          padding: const EdgeInsets.only(left: 17),
          child: Row(
            children: [
              Container(width: width*0.1,height: heigth*0.07,alignment: Alignment.center,
                  decoration: BoxDecoration(border:Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)
                      ),color: Colors.grey.shade300),
                  child: Text("+91",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)
              ),
              Container(
                width: width*0.8,height: heigth*0.07,
                decoration: BoxDecoration(border:Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                  ),),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: number,
                    decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    border: InputBorder.none,hintText:selectedRadio==0?"Enter PayTm Number":selectedRadio==1?"Enter google pay number":"Enter phonepay number",
                    hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400))
                ),
              ),
            ],
          ),
        ),SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 17),
          child: Row(
            children: [
              Container(width: width*0.1,height: heigth*0.07,alignment: Alignment.center,
                  decoration: BoxDecoration(border:Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)
                      ),color: Colors.grey.shade300),
                  child: Text("₹",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)
              ),
              Container(
                width: width*0.8,height: heigth*0.07,
                decoration: BoxDecoration(border:Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                  ),),
                child: TextField(
                  keyboardType: TextInputType.number,
                    controller: amount,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        border: InputBorder.none,hintText: "Enter Withdraw Amount",
                        hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400))
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
  Deposit( String name ,String number,String amount )async{
    print("😂😂😂😂😂😂");
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    setState(() {
      loading=true;
    });

    final response=await http.post(
      Uri.parse(Apiconst.Withdrawal_money),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid" : '$userid',
        "name" : name,
        "amount":amount,
        "mobile":number,
        "type":selectedRadio==0?"paytm":selectedRadio==1?"google pay":"phonepay",
      }),
    );
    final data=jsonDecode(response.body);
    if(data["error"]=='200'){
      setState(() {
        loading=false;
      });

      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>History()));
    }else{
      setState(() {
        loading=false;
      });
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    print(data);
  }
}
