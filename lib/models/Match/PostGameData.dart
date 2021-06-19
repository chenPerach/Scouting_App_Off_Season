import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/model.dart';

class PostGameData extends Model {
  String comment;
  WinningState winningState;

  PostGameData({this.comment,this.winningState});
  @override
  Map<String, dynamic> toJson() => {
      "comment": comment,
      "game_result": winningState.type
    };

  PostGameData fromJson(Map<String,dynamic> json){
    return PostGameData(
      comment: json["comment"],
      winningState: WinningState.generate(json["game_result"]),
    );
  }
}

class WinningState {
  String type;
  Image image;
  WinningState({this.type,this.image});
  static const String win="WIN",draw="DRAW",loss='LOSS';
  factory WinningState.generate(String type){
    var obj;
    switch (type) {
      case win:
        obj =  WinningState(type: win,image: Image.asset("assets/images/FinishScreen/Win.png"));
        break;
        case loss:
        obj = WinningState(type: loss,image: Image.asset("assets/images/FinishScreen/Loss.png"));
        break;
        case draw:
        obj= WinningState(type: loss,image: Image.asset("assets/images/FinishScreen/Draw.png"));
        break;
      default:
    }
    return obj;
  }
}

class WinningStateGenerator {
  static int _i =0;
  static WinningState next(){
    var obj;
    switch (_i) {
      case 0:
        obj = WinningState.generate(WinningState.win);
        break;
        case 1:
        obj = WinningState.generate(WinningState.draw);
        break;
        case 2:
        obj = WinningState.generate(WinningState.loss);
        break;
      default:
    }
    _i = (_i+1)%3;
    return obj;
  }
}