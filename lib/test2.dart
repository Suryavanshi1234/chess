// import 'dart:convert';
// import 'dart:math';
//
// import 'package:chess_bot/wholeproject/More/history.dart';
// import 'package:chess_bot/wholeproject/constant.dart';
// import 'package:chess_bot/wholeproject/home/webview.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:upi_india/upi_india.dart';
// import 'package:http/http.dart' as http;
//
//
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final TextEditingController rupees = TextEditingController();
//
//
//   Future<UpiResponse> _transaction;
//   UpiIndia _upiIndia = UpiIndia();
//   List<UpiApp> apps;
//
//   TextStyle header = TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );
//
//   TextStyle value = TextStyle(
//     fontWeight: FontWeight.w400,
//     fontSize: 14,
//   );
//
//   @override
//   void initState() {
//     _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
//       setState(() {
//         apps = value;
//       });
//     }).catchError((e) {
//       apps = [];
//     });
//     super.initState();
//   }
//
//   Future<UpiResponse> initiateTransaction(UpiApp app,String rupee) async {
//       final width = MediaQuery.of(context).size.width;
//       final height = MediaQuery.of(context).size.height;
//     return _upiIndia.startTransaction(
//       app: app,
//       receiverUpiId: "Getepay.mbandhan77731@icici",
//       receiverName: 'Abhishek jaiswal',
//       transactionRefId: 'TestingUpiIndiaPlugin',
//       transactionNote: 'Not actual. Just an example.',
//       amount:  1.00,
//     );
//   }
//
//   Widget displayUpiApps() {
//     if (apps == null)
//       return Center(child: CircularProgressIndicator());
//     else if (apps.length == 0)
//       return Center(
//         child: Text(
//           "No apps found to handle transaction.",
//           style: header,
//         ),
//       );
//     else
//       return Align(
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Wrap(
//             children: apps.map<Widget>((UpiApp app) {
//               return GestureDetector(
//                 onTap: () {
//                   _transaction = initiateTransaction(app,rupees.text);
//                   setState(() {});
//                 },
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Image.memory(
//                         app.icon,
//                         height: 60,
//                         width: 60,
//                       ),
//                       Text(app.name),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//   }
//   Widget displayUpiApps() {
//
//     if (apps == null)
//       return Center(child: CircularProgressIndicator());
//     else if (apps.length == 0)
//       return ElevatedButton(
//           onPressed: () async {
//             final prefs = await SharedPreferences.getInstance();
//             final userid = prefs.getString("userId");
//
//             Random random = new Random();
//             int randomNumber = random.nextInt(1000000); //
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => Payurl(
//                       url:
//                       "https://nk.wishufashion.com/phonepay/amount.php?auth=NTM1NDU0MzUyNDUyNDM1NjQyMzY1Mg==&name=test&mobile=12345678900&amount=${rupees.text}&orderid=$randomNumber&userid=$userid&paytype=101",
//                     )));
//           },
//           child: Text('Upi Apps', style: header));
//     else
//       return Align(
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               // SizedBox(
//               //   height: 50,
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.only(left: 25),
//               //   child: buildTextField(width, height),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.only(top: 15, left: 50),
//               //   child: Text(
//               //     "Minimum Add Amount is ₹50",
//               //     style: TextStyle(
//               //         fontSize: 20,
//               //         fontWeight: FontWeight.w500,
//               //         color: primaryColor),
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.fromLTRB(26, 15, 8, 15),
//               //   child: Text(
//               //     "*Note: deposit amount can't be withdrawable and it will be\n            "
//               //         " use to join paid contest in our app.",
//               //     style:
//               //     TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12),
//               //   ),
//               // ),
//               // Container(
//               //   child: Center(
//               //       child: Text(
//               //         "PAY USING",
//               //         style: TextStyle(
//               //             fontSize: 20,
//               //             color: Colors.black,
//               //             fontWeight: FontWeight.w900),
//               //       )),
//               // ),
//               // SizedBox(
//               //   height: 20,
//               // ),
//               Wrap(
//                 children: apps.map<Widget>((UpiApp app) {
//                   return GestureDetector(
//                     onTap: app.name == 'PhonePe'
//                         ? () async {
//                       final prefs = await SharedPreferences.getInstance();
//                       final userid = prefs.getString("userId");
//
//                       Random random = new Random();
//                       int randomNumber =
//                       random.nextInt(1000000); // from 0 to 9 included
//
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Payurl(
//                                 url:
//                                 "https://nk.wishufashion.com/phonepay/amount.php?auth=NTM1NDU0MzUyNDUyNDM1NjQyMzY1Mg==&name=test&mobile=12345678900&amount=${rupees.text}&orderid=$randomNumber&userid=$userid&paytype=101 ",
//                               )));
//                       // Deposit(rupees.text,);
//                     }
//                         : () {
//                       // if (rupees.text != null && rupees.text.isNotEmpty) {
//                       _transaction = initiateTransaction(app, rupees.text);
//                       // } else {
//                       //   print('enter valid amount');
//                       // }
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Image.memory(
//                             app.icon,
//                             height: 60,
//                             width: 60,
//                           ),
//                           Text(app.name),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       );
//   }
//
//   String _upiErrorHandler(error) {
//     switch (error) {
//       case UpiIndiaAppNotInstalledException:
//         return 'Requested app not installed on device';
//       case UpiIndiaUserCancelledException:
//         return 'You cancelled the transaction';
//       case UpiIndiaNullResponseException:
//         return 'Requested app didn\'t return any response';
//       case UpiIndiaInvalidParametersException:
//         return 'Requested app cannot handle the transaction';
//       default:
//         return 'An Unknown error has occurred';
//     }
//   }
//
//   void _checkTxnStatus(String status) {
//     switch (status) {
//       case UpiPaymentStatus.SUCCESS:
//         userDeposit('1');
//         print('Transaction Successful');
//         break;
//       case UpiPaymentStatus.SUBMITTED:
//         print('Transaction Submitted');
//         break;
//       case UpiPaymentStatus.FAILURE:
//         print('Transaction Failed');
//         break;
//       default:
//         print('Received an Unknown transaction status');
//     }
//   }
//
//   Widget displayTransactionData(title, body) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("$title: ", style: header),
//           Flexible(
//               child: Text(
//                 body,
//                 style: value,
//               )),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back)),
//         title: Text(
//           "Deposit Money",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: primaryColor,
//       ),
//       body: Column(
//         children: <Widget>[
//           displayUpiApps(),
//           FutureBuilder(
//             future: _transaction,
//             builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       _upiErrorHandler(snapshot.error.runtimeType),
//                       style: header,
//                     ), // Print's text message on screen
//                   );
//                 }
//
//                 // If we have data then definitely we will have UpiResponse.
//                 // It cannot be null
//                 UpiResponse _upiResponse = snapshot.data;
//
//                 // Data in UpiResponse can be null. Check before printing
//                 String txnId = _upiResponse.transactionId ?? 'N/A';
//                 String resCode = _upiResponse.responseCode ?? 'N/A';
//                 String txnRef = _upiResponse.transactionRefId ?? 'N/A';
//                 String status = _upiResponse.status ?? 'N/A';
//                 String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
//                 _checkTxnStatus(status);
//
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       displayTransactionData('Transaction Id', txnId),
//                       displayTransactionData('Response Code', resCode),
//                       displayTransactionData('Reference Id', txnRef),
//                       displayTransactionData('Status', status.toUpperCase()),
//                       displayTransactionData('Approval No', approvalRef),
//                     ],
//                   ),
//                 );
//               } else
//                 return Center(
//                   child: Text(''),
//                 );
//             },
//           )
//         ],
//       ),
//
//
//
//       // Column(
//       //   children: <Widget>[
//       //     SizedBox(
//       //       height: 50,
//       //     ),
//       //     Padding(
//       //       padding: const EdgeInsets.only(left: 25),
//       //       child: buildTextField(width, height),
//       //     ),
//       //     Padding(
//       //       padding: const EdgeInsets.only(top: 15, left: 50),
//       //       child: Text(
//       //         "Minimum Add Amount is ₹50",
//       //         style: TextStyle(
//       //             fontSize: 20,
//       //             fontWeight: FontWeight.w500,
//       //             color: primaryColor),
//       //       ),
//       //     ),
//       //
//       //     Padding(
//       //       padding: const EdgeInsets.fromLTRB(26, 15, 8, 15),
//       //       child: Text(
//       //         "*Note: deposit amount can't be withdrawable and it will be\n            "
//       //             " use to join paid contest in our app.",
//       //         style:
//       //         TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12),
//       //       ),
//       //     ),
//       //     Container(
//       //       child: Center(
//       //           child: Text(
//       //             "PAY USING",
//       //             style: TextStyle(
//       //                 fontSize: 20,
//       //                 color: Colors.black,
//       //                 fontWeight: FontWeight.w900),
//       //           )),
//       //     ),
//       //     SizedBox(
//       //       height: 20,
//       //     ),
//       //     displayUpiApps(),
//       //     Expanded(
//       //       child: FutureBuilder(
//       //         future: _transaction,
//       //         builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
//       //           if (snapshot.connectionState == ConnectionState.done) {
//       //             if (snapshot.hasError) {
//       //               return Center(
//       //                 child: Text(
//       //                   _upiErrorHandler(snapshot.error.runtimeType),
//       //                   style: header,
//       //                 ), // Print's text message on screen
//       //               );
//       //             }
//       //
//       //             // If we have data then definitely we will have UpiResponse.
//       //             // It cannot be null
//       //             UpiResponse _upiResponse = snapshot.data;
//       //
//       //             // Data in UpiResponse can be null. Check before printing
//       //             String txnId = _upiResponse.transactionId ?? 'N/A';
//       //             String resCode = _upiResponse.responseCode ?? 'N/A';
//       //             String txnRef = _upiResponse.transactionRefId ?? 'N/A';
//       //             String status = _upiResponse.status ?? 'N/A';
//       //             String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
//       //             _checkTxnStatus(status);
//       //
//       //             return Padding(
//       //               padding: const EdgeInsets.all(8.0),
//       //               child: Column(
//       //                 mainAxisAlignment: MainAxisAlignment.center,
//       //                 children: <Widget>[
//       //                   displayTransactionData('Transaction Id', txnId),
//       //                   displayTransactionData('Response Code', resCode),
//       //                   displayTransactionData('Reference Id', txnRef),
//       //                   displayTransactionData('Status', status.toUpperCase()),
//       //                   displayTransactionData('Approval No', approvalRef),
//       //                 ],
//       //               ),
//       //             );
//       //           } else
//       //             return Center(
//       //               child: Text(''),
//       //             );
//       //         },
//       //       ),
//       //     )
//       //   ],
//       // ),
//     );
//   }
//   Widget buildTextField(width, height) {
//     return Row(
//       children: [
//         Container(
//             width: width * 0.09,
//             height: height * 0.07,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(5),
//                     bottomLeft: Radius.circular(5)),
//                 color: Colors.grey.shade400),
//             child: Text(
//               "₹",
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
//             )),
//         Container(
//           width: width * 0.8,
//           height: height * 0.07,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
//           ),
//           child: TextField(
//               controller: rupees,
//               decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   border: InputBorder.none,
//                   hintText: "Enter Deposit Amount",
//                   hintStyle:
//                   TextStyle(fontSize: 21, fontWeight: FontWeight.w500))),
//         ),
//       ],
//     );
//   }
//
//
//   userDeposit(String rupees) async {
//     print("innsert fun invoked....");
//     final prefs = await SharedPreferences.getInstance();
//     final userid = prefs.getString("userId");
//     print(userid);
//     print(rupees);
//     print('Ajay');
//     final response = await http.post(
//       Uri.parse(Apiconst.Deposit_money),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         "userid": '$userid',
//         "amount": rupees,
//         "discription": "Deposited Money"
//       }),
//     );
//     final data = jsonDecode(response.body);
//     print("rama rama");
//     print(data);
//     print("rama rama");
//     if (data["error"] == '200') {
//       print(data['msg']);
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => History()));
//     } else {
//       print(data['msg']);
//     }
//   }
//
// }
//
//
// // void main() => runApp(MyApp());
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Test UPI',
// //       home: HomePage(),
// //     );
// //   }
// // }
// //
// // class HomePage extends StatefulWidget {
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //   Future<UpiResponse> _transaction;
// //   UpiIndia _upiIndia = UpiIndia();
// //   List<UpiApp> apps;
// //
// //   TextStyle header = TextStyle(
// //     fontSize: 18,
// //     fontWeight: FontWeight.bold,
// //   );
// //
// //   TextStyle value = TextStyle(
// //     fontWeight: FontWeight.w400,
// //     fontSize: 14,
// //   );
// //
// //   @override
// //   void initState() {
// //     _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
// //       setState(() {
// //         apps = value;
// //       });
// //     }).catchError((e) {
// //       apps = [];
// //     });
// //     super.initState();
// //   }
// //
// //   Future<UpiResponse> initiateTransaction(UpiApp app) async {
// //     return _upiIndia.startTransaction(
// //       app: app,
// //       receiverUpiId: "9078600498@ybl",
// //       receiverName: 'Md Azharuddin',
// //       transactionRefId: 'TestingUpiIndiaPlugin',
// //       transactionNote: 'Not actual. Just an example.',
// //       amount: 1.00,
// //     );
// //   }
// //
// //   Widget displayUpiApps() {
// //     if (apps == null)
// //       return Center(child: CircularProgressIndicator());
// //     else if (apps.length == 0)
// //       return Center(
// //         child: Text(
// //           "No apps found to handle transaction.",
// //           style: header,
// //         ),
// //       );
// //     else
// //       return Align(
// //         alignment: Alignment.topCenter,
// //         child: SingleChildScrollView(
// //           physics: BouncingScrollPhysics(),
// //           child: Wrap(
// //             children: apps.map<Widget>((UpiApp app) {
// //               return GestureDetector(
// //                 onTap: () {
// //                   _transaction = initiateTransaction(app);
// //                   setState(() {});
// //                 },
// //                 child: Container(
// //                   height: 100,
// //                   width: 100,
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: <Widget>[
// //                       Image.memory(
// //                         app.icon,
// //                         height: 60,
// //                         width: 60,
// //                       ),
// //                       Text(app.name),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       );
// //   }
// //
// //   String _upiErrorHandler(error) {
// //     switch (error) {
// //       case UpiIndiaAppNotInstalledException:
// //         return 'Requested app not installed on device';
// //       case UpiIndiaUserCancelledException:
// //         return 'You cancelled the transaction';
// //       case UpiIndiaNullResponseException:
// //         return 'Requested app didn\'t return any response';
// //       case UpiIndiaInvalidParametersException:
// //         return 'Requested app cannot handle the transaction';
// //       default:
// //         return 'An Unknown error has occurred';
// //     }
// //   }
// //
// //   void _checkTxnStatus(String status) {
// //     switch (status) {
// //       case UpiPaymentStatus.SUCCESS:
// //         print('Transaction Successful');
// //         break;
// //       case UpiPaymentStatus.SUBMITTED:
// //         print('Transaction Submitted');
// //         break;
// //       case UpiPaymentStatus.FAILURE:
// //         print('Transaction Failed');
// //         break;
// //       default:
// //         print('Received an Unknown transaction status');
// //     }
// //   }
// //
// //   Widget displayTransactionData(title, body) {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text("$title: ", style: header),
// //           Flexible(
// //               child: Text(
// //                 body,
// //                 style: value,
// //               )),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('UPI'),
// //       ),
// //       body: Column(
// //         children: <Widget>[
// //           Expanded(
// //             child: displayUpiApps(),
// //           ),
// //           Expanded(
// //             child: FutureBuilder(
// //               future: _transaction,
// //               builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.done) {
// //                   if (snapshot.hasError) {
// //                     return Center(
// //                       child: Text(
// //                         _upiErrorHandler(snapshot.error.runtimeType),
// //                         style: header,
// //                       ), // Print's text message on screen
// //                     );
// //                   }
// //
// //                   // If we have data then definitely we will have UpiResponse.
// //                   // It cannot be null
// //                   UpiResponse _upiResponse = snapshot.data;
// //
// //                   // Data in UpiResponse can be null. Check before printing
// //                   String txnId = _upiResponse.transactionId ?? 'N/A';
// //                   String resCode = _upiResponse.responseCode ?? 'N/A';
// //                   String txnRef = _upiResponse.transactionRefId ?? 'N/A';
// //                   String status = _upiResponse.status ?? 'N/A';
// //                   String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
// //                   _checkTxnStatus(status);
// //
// //                   return Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: <Widget>[
// //                         displayTransactionData('Transaction Id', txnId),
// //                         displayTransactionData('Response Code', resCode),
// //                         displayTransactionData('Reference Id', txnRef),
// //                         displayTransactionData('Status', status.toUpperCase()),
// //                         displayTransactionData('Approval No', approvalRef),
// //                       ],
// //                     ),
// //                   );
// //                 } else
// //                   return Center(
// //                     child: Text(''),
// //                   );
// //               },
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }