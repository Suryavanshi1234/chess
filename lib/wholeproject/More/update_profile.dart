import 'dart:convert';
import 'dart:io';


import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class Update_Profile extends StatefulWidget {

  final profile;
  const Update_Profile({Key key,   this.profile}) : super(key: key);

  @override
  State<Update_Profile> createState() => _Update_ProfileState();
}
class _Update_ProfileState extends State<Update_Profile> {
  @override
  TextEditingController _name= TextEditingController();
  TextEditingController _email= TextEditingController();
  TextEditingController _phone= TextEditingController();
  bool loading=false;


  Aman(){
    setState(() {
      _name.text = widget.profile['fullname'].toString();
      _email.text= widget.profile['email'].toString();
      _phone.text= widget.profile['mobile'].toString();
    });

  }

  void initState() {

    Aman();
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
      title: Text("Update Profile",
        style: TextStyle(color: Colors.white),
      ),
      ),
      body:ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: _choose,
                  child: Center(
                    child: Stack(
                      children: [
                        file != null
                            ? CircleAvatar(
                          backgroundImage: FileImage(file),
                          radius: 50,
                        ) : widget.profile['image']== null? CircleAvatar(
                          radius: 50,
                        backgroundImage: AssetImage("assets/images/no-image-available.png"),):
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            Apiconst.Imageurl+widget.profile['image'].toString(),
                          ),
                          radius: 50,
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor:primaryColor,
                              radius: 15,
                              child: Icon(Icons.camera_alt_outlined),
                            )),
                      ],
                    ),
                  ),
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(
                            width: 1, color: primaryColor),
                      ),
                      enabledBorder: UnderlineInputBorder( //<-- SEE HERE
                    borderSide: BorderSide(
                        width: 1, ),
                  ),
                      labelText: "Name"),
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(
                        width: 1, color: primaryColor),
                  ),
                      enabledBorder: UnderlineInputBorder( //<-- SEE HERE
                    borderSide: BorderSide(
                        width: 1, ),
                  ),
                      labelText: "Email"),
                ),SizedBox(height: 10,),
                IntlPhoneField(
                  controller: _phone,
                  disableLengthCheck: true,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(
                            width: 1, color: primaryColor),
                      ),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: primaryColor.withOpacity(0.6)) ,
                      enabledBorder: UnderlineInputBorder(
                        //<-- SEE HERE
                        borderSide: BorderSide(
                            width: 1, ),
                      )
                  ),
                  initialCountryCode: 'IN',
                  dropdownIconPosition: IconPosition.trailing,style: TextStyle(color: primaryColor),
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 10),
                  child: SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {
                          // _userlogin(
                          //   mobile.text,password.text,
                          // );
                          UpdateProfile(_name.text,_email.text,_phone.text);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),

                        child:
                        loading == false?
                        Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ):
                        Padding(
                          padding:  EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircularProgressIndicator(
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white)),
                              Text(
                                "Please Wait...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      )) ;
  }

  var mydata;
  File file;
  final picker = ImagePicker();
  void _choose() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        final bytes = File(pickedFile.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        mydata = img64;
        print('Abhinav');
        print(img64);
        print('Thi');
      } else {
        print('No image selected.');
      }
    });
  }
  UpdateProfile(String _name,String _email,String _phone)async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    setState(() {
      loading=true;
    });
    final response=await http.post(
      Uri.parse(Apiconst.Updateprofile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": '${userid}',
        "fullname":_name ,
        "email":_email,
        "mobile":_phone,
        "image":mydata,




      }),
    );
    final data=jsonDecode(response.body);
    if(data["success"]=='200'){
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>bottom()));
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
