
import 'package:chess_bot/MainGameModel/PlayUnlimited/util/online_game_utils.dart';
import 'package:flutter/cupertino.dart';

class DividerIfOffline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !inOnlineGame,
        child: Divider8()
    );
  }
}

class Divider8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 8,);
  }
}
