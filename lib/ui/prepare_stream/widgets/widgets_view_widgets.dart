import 'package:flutter/material.dart';

class WidgetsViewWidgets {}

class VictorineDialog extends StatefulWidget {
  VictorineDialog({Key key}) : super(key: key);

  @override
  _VictorineDialogState createState() => _VictorineDialogState();
}

class _VictorineDialogState extends State<VictorineDialog> {
  TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _textContollers =
      List.generate(3, (index) => TextEditingController());
  int _groupValue;
  double _sliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _questionController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      hintText: "Вопрос",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 200,
                    child: ListView.separated(
                      itemCount: _textContollers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  controller: _textContollers[index],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: "Ответ",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Radio(
                                value: index,
                                groupValue: _groupValue,
                                onChanged: (int value) {
                                  print(value);
                                  setState(() {
                                    _groupValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 15),
                    ),
                  ),
                  Slider(
                    value: _sliderValue,
                    onChanged: (double value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    divisions: 2,
                    label: _sliderValue.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
