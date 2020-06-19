import 'package:flutter/material.dart';

class WidgetsViewWidgets {
  Dialog victorineDialog = Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text("Сохранить"),
            ),
            Text("Викторина"),
          ],
        ),
        Divider(
          color: Colors.black45,
        ),
      ],
    ),
  );
}
