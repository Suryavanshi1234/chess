import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Fire extends StatefulWidget {
  const Fire({Key key}) : super(key: key);

  @override
  State<Fire> createState() => _FireState();
}

class _FireState extends State<Fire> {


  pj(){
for(var i=113000; i<=113999; i++) {
  Map<String, dynamic> game = {};
  game['white'] = null;
  game['black'] = null;
  game['fen'] = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
  game['moveFrom'] = null;
  game['moveTo'] = null;
  game['id'] = i.toString();
  FirebaseFirestore.instance.collection('games').doc(i.toString()).set(game);
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: ElevatedButton(
          onPressed: (){
            pj();
          },
          child: Text("Suc"),
        ),
      ));
  }
}
