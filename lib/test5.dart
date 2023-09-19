// Future<bool> _onWillPop() async {
//   final isRunning = countdownTimer == null ? false : countdownTimer!.isActive;
//   if (isRunning) {
//     countdownTimer!.cancel();
//
//   }
//   Navigator.of(context, rootNavigator: true).pop(context);
//   return true;
// }
// Timer? countdownTimer;
// Duration myDuration = Duration(minutes: 2);
// void startTimer() {
//   countdownTimer =
//       Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
// }
//
// void stopTimer() {
//   setState(() => countdownTimer!.cancel());
// }
// // Step 5
// void resetTimer() {
//   stopTimer();
//   setState(() => myDuration = Duration(minutes: 2));
// }
// // Step 6
//
// late DateTime _dateTime;
// bool frist=true;
// bool hide=false;
//
// void setCountDown() {
//   hiddenbat();
//   final reduceSecondsBy = 1;
//   _dateTime = DateTime.now().toUtc();
//   if(frist==true){
//
//     setState(() {
//       frist=false;
//     });
//     if(_dateTime.minute.isOdd){
//       final seconds=   120-60-_dateTime.second;
//       myDuration = Duration(seconds: seconds);
//
//     }else{
//       final seconds=   120-_dateTime.second;
//       myDuration = Duration(seconds: seconds);
//     }
//
//
//   }else{
//     setState(() {
//       final seconds = myDuration.inSeconds - reduceSecondsBy;
//       if (seconds < 0) {
//         // countdownTimer!.cancel();
//         periodget();
//         qwe(0);
//         Partelyrecord(0);
//         walletview();
//         startTimer();
//         resetTimer();
//
//
//       } else {
//         myDuration = Duration(seconds: seconds);
//         print(seconds);
//       }
//     });
//   }
// }
//
// Color colord=kGreyColor600;
// void hiddenbat(){
//   if(myDuration.inSeconds==30){
//     setState(() {
//       colord=Colors.red;
//     });
//   }else if(myDuration.inSeconds==60){
//     setState(() {
//       colord=Colors.yellow;
//     });
//   }else if(myDuration.inMinutes==01){
//     setState(() {
//       colord=Colors.green;
//     });
//   }
//
//   if(myDuration.inSeconds<32 ){
//     setState(() {
//       hide=true;
//     });
//     if(popups==true&& myDuration.inSeconds==30){
//       setState(() {
//         popups=false;
//       });
//       Navigator.pop(context);
//     }
//     // if(hide==true&& myDuration.inSeconds==60){
//     //   setState(() {
//     //     hide=false;
//     //   });
//     //   Navigator.pop(context);
//     // }
//   }else{
//     setState(() {
//       hide=false;
//     });
//   }
//
// }
//
// Widget buildTime1() {
//   String strDigits(int n) => n.toString().padLeft(2, '0');
//   final minutes = strDigits(myDuration.inMinutes.remainder(2));
//   final seconds = strDigits(myDuration.inSeconds.remainder(60));
//   return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//     buildTimeCard(time: minutes, header: 'MINUTES'),
//     SizedBox(
//       width: 8,
//     ),
//     buildTimeCard(time: seconds, header: 'SECONDS'),
//   ]);
// }
//
// Widget buildTimeCard({required String time, required String header}) =>
//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//
//               color:  colord,
//               borderRadius: BorderRadius.circular(10)),
//           child: Text(
//             time,
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: kBlackColor900,
//                 fontSize: 15),
//           ),
//         ),
//       ],
//     );