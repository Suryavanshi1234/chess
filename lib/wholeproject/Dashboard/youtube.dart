import 'package:chess_bot/wholeproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtube extends StatefulWidget {
  const Youtube({Key key}) : super(key: key);

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  final videoURL="https://www.youtube.com/watch?v=g-LIs4XD_eI";
   YoutubePlayerController _controller;
  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller=YoutubePlayerController(initialVideoId: videoID);

    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(elevation: 0,centerTitle: true,
          leading: Image.asset("assets/images/ChessLogo.png"),
          title: Text(
            "Realmoneychess",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          backgroundColor: primaryColor,
        ),
        body: ListView
          (
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(alignment: Alignment.center,
              height:height,
              width: width,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.jpg"),fit: BoxFit.fill,)),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  YoutubePlayer(controller: _controller,
                  showVideoProgressIndicator: true,)
                ],
              ),
            )
          ],
        ));
  }
}
