import 'package:flutter/material.dart';
import 'package:todo/utils/color.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: tdBGColor,
    actions: [
      Container(
        child: CircleAvatar(
            radius: 25, backgroundImage: AssetImage("assets/images/Saim.JPG")),
        margin: EdgeInsets.only(right: 10),
      )
    ],
  );
}

