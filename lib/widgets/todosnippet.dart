import 'package:flutter/material.dart';
import 'package:todo/utils/color.dart';

Widget todoSnippet({required isDone, text, index, required Function onDelete, required Function onToggle}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    tileColor: Colors.white,
    leading: IconButton(onPressed: () {
      onToggle();
    }, icon: Icon(isDone ? Icons.check_box : Icons.check_box_outline_blank, color: tdBlue)),
    title: Text(text, style: TextStyle(decoration: isDone ? TextDecoration.lineThrough : null)),
    trailing: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: tdRed),
      child: IconButton(onPressed: () {
        onDelete();
      }, icon: Icon(Icons.delete, color: Colors.white, size: 19))
    ),
  ),
  );
}