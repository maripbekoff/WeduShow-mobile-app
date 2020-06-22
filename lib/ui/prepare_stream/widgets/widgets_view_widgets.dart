import 'package:flutter/material.dart';

class WidgetsViewWidgets {
  Dialog victorineDialog = Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(
                  "Сохранить",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              Text(
                "Викторина",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                onPressed: null,
                child: Container(),
              ),
            ],
          ),
        ),
        Divider(color: Colors.black45),
        Form(
          child: Column(
            children: <Widget>[
              TextField(),
            ],
          ),
        ),
      ],
    ),
  );
}
