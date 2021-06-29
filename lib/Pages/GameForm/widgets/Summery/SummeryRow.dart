import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummeryRow extends StatelessWidget {
  final Widget title,item;
  SummeryRow({this.item,this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Container(child: title,color: Theme.of(context).backgroundColor,),flex:2),
        Flexible(child: item,flex:3),
      ],
    );
  }
}

class SummeryRowDouble extends StatelessWidget {
  final Widget title,first,second;
  SummeryRowDouble({this.first,this.title,this.second});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Flexible(child: Container(child: title,color: Theme.of(context).backgroundColor,),flex:4),
          Flexible(child: first,flex:3),
          Flexible(child: second,flex:3),
        ],
      ),
    );
  }
}