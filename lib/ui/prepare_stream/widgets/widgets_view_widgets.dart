import 'package:flutter/material.dart';

class WidgetsViewWidgets {
  static TextEditingController _questionController = TextEditingController();
  static List _form =
      List.generate(3, (index) => [TextEditingController(), index]);
  static int _groupValue;

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
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Вопрос",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: _form.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            controller: _form[index][0],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: "Ответ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                          ),
                        ),
                        Radio(
                          value: _form[index][1],
                          groupValue: _groupValue,
                          onChanged: (T) {
                            T = _groupValue;
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
