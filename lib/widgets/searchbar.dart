import 'package:flutter/material.dart';

Widget SearchbBarWidget({required Function Filter}) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white,),
    child: TextField(
      onChanged: (value) {
        Filter(value);
      },
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderSide: BorderSide.none)
      ),
    ),
  );
}