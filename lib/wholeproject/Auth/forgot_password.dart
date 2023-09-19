import 'dart:convert';

import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool showValue = false;
  bool showButtonValue = false;
  bool isOtpVarified = false;
  var otp;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  // void sendOTP()async{
  //   EmailAuth.sessionName ="Otp Session";
  //   var res = await EmailAuth.sendOtp(recieverMail:EmailController.text);
  //   if (res){}
  // }
  // void verifyOTP() async{
  //   var res = EmailAuth.validate(recieverMail:EmailController.text , userOTP:otpController.text);
  //   if(res){
  //     print("OTP Verified");
  //   }
  //   else{
  //     print
  //       ("Invalid OTP");
  //     }
  //   }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17, top: 40),
                    child: Text(
                      "Forgot\nyour \nAccount \nPassword?",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Image(
                      image: AssetImage(
                        "assets/images/Register3.png",
                      ),
                      height: height * 0.23,
                    ),
                  )
                ],
              ),
              isOtpVarified == false
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Container(
                          height: height * 0.4,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        //<-- SEE HERE
                                        borderSide: BorderSide(
                                            width: 1, color: primaryColor),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        //<-- SEE HERE
                                        borderSide: BorderSide(
                                          width: 1,
                                        ),
                                      ),
                                      suffixIcon: TextButton(
                                          child: Text("Send OTP"),
                                          onPressed: () {
                                            Forgot(emailController.text);

                                            Fluttertoast.showToast(
                                                msg: "OTP send",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.TOP,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }),
                                      labelText: "Email"),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                if (showValue)
                                  TextField(
                                    controller: otpController,
                                    onChanged: (v) {
                                      if (v.length == 5) {
                                        setState(() {
                                          showButtonValue = !showButtonValue;
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                              width: 1, color: primaryColor),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                            width: 1,
                                          ),
                                        ),
                                        hintText: "Enter OTP",
                                        labelText: "OTP"),
                                  ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                showButtonValue == true
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black),
                                        onPressed: () {
                                          verifyotp(otpController.text);
                                        },
                                        child: Text("Verify OTP"))
                                    : Container()
                              ],
                            ),
                          )
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                          //   child: Column(
                          //     children: [
                          //       Row(mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             "Country Code",
                          //             style: TextStyle(
                          //                 color: Colors.black.withOpacity(0.2),
                          //                 fontWeight: FontWeight.w500,
                          //                 fontSize: 13),
                          //           ),
                          //         ],
                          //       ),
                          //       IntlPhoneField(
                          //         disableLengthCheck: true,
                          //         decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                          //           //<-- SEE HERE
                          //           borderSide: BorderSide(
                          //               width: 1, color: primaryColor),
                          //         ),
                          //             hintText: 'Phone Number',
                          //             enabledBorder: UnderlineInputBorder(
                          //               //<-- SEE HERE
                          //               borderSide: BorderSide(
                          //                   width: 1, color: Colors.black),
                          //             )),
                          //         initialCountryCode: 'IN',
                          //         dropdownIconPosition: IconPosition.trailing,
                          //         onChanged: (phone) {
                          //           print(phone.completeNumber);
                          //         },
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(top: 20),
                          //         child: Container(
                          //           alignment: Alignment.center,
                          //           height: 42, width: 160,
                          //           //color: Colors.redAccent,
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.all(Radius.circular(30)),
                          //             color: Colors.black,
                          //           ),
                          //           child: Text(
                          //             "GENERATE OTP",
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.w600,
                          //                 fontSize: 14,
                          //                 color: Colors.white),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          ),
                    )
                  : Container(
                      height: height * 0.4,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _form,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: newPassword,
                                validator: (val) {
                                  if (val.isEmpty) return 'Empty';
                                  return null;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1, color: primaryColor),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    labelText: "New Password"),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextFormField(
                                controller: confirmPassword,
                                validator: (val) {
                                  if (val.isEmpty) return 'Empty';
                                  if (val != newPassword.text) return null;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                          width: 1, color: primaryColor),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      //<-- SEE HERE
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    labelText: "Confirm Password"),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black),
                                  onPressed: () {
                                    ChangePass(emailController.text,
                                        newPassword.text, confirmPassword.text);
                                  },
                                  child: Text("Change Password"))
                            ],
                          ),
                        ),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      //   child: Column(
                      //     children: [
                      //       Row(mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Country Code",
                      //             style: TextStyle(
                      //                 color: Colors.black.withOpacity(0.2),
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 13),
                      //           ),
                      //         ],
                      //       ),
                      //       IntlPhoneField(
                      //         disableLengthCheck: true,
                      //         decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                      //           //<-- SEE HERE
                      //           borderSide: BorderSide(
                      //               width: 1, color: primaryColor),
                      //         ),
                      //             hintText: 'Phone Number',
                      //             enabledBorder: UnderlineInputBorder(
                      //               //<-- SEE HERE
                      //               borderSide: BorderSide(
                      //                   width: 1, color: Colors.black),
                      //             )),
                      //         initialCountryCode: 'IN',
                      //         dropdownIconPosition: IconPosition.trailing,
                      //         onChanged: (phone) {
                      //           print(phone.completeNumber);
                      //         },
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 20),
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           height: 42, width: 160,
                      //           //color: Colors.redAccent,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.all(Radius.circular(30)),
                      //             color: Colors.black,
                      //           ),
                      //           child: Text(
                      //             "GENERATE OTP",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.w600,
                      //                 fontSize: 14,
                      //                 color: Colors.white),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      )
            ],
          ),
        ],
      ),
    ));
  }

  Forgot(String emailController) async {
    final res = await http.get(Uri.parse(Apiconst.OTP+"$emailController"));
    final data = jsonDecode(res.body);
    print(data);
    print("emailController");
    print(emailController);
    print("emailController");
    if (data["error"] == '200') {
      setState(() {
        otp = data['otp'];
        showValue = !showValue;
      });
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    print(otp);
    print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
  }

  verifyotp(String otpController) {
    if (otpController.isNotEmpty && otpController == otp.toString()) {
      print(otpController.isNotEmpty && otpController == otp.toString());
      print("success");

      setState(() {
        isOtpVarified = true;
      });
    } else {
      print("Failed");
      Fluttertoast.showToast(
          msg: "Invalid OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  ChangePass(String emailController, String newPassword,
      String confirmPassword) async {
    final res = await http.get(Uri.parse(
        "https://apponrent.co.in/chess/api/forgetpassword.php?email=$emailController&newpassword=$newPassword&confirmpassword=$confirmPassword"));
    final data = jsonDecode(res.body);
    print(data);
    if (data["error"] == '200') {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    } else {
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
