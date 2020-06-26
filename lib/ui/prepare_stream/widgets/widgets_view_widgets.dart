import 'package:flutter/cupertino.dart';
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
  int _index;
  List<int> _pageValue = [1];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
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
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
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
                      SizedBox(height: 25),
                      Text("Время на ответ"),
                      Slider(
                        value: _sliderValue,
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue = value;
                          });
                        },
                        min: 5,
                        max: 15,
                        divisions: 2,
                        label: "${_sliderValue.toInt()} сек.",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: _pageValue.length,
                                itemBuilder: (BuildContext context, int index) {
                                  _index = index + 2;
                                  return IconButton(
                                    onPressed: () {},
                                    icon: Text("${_pageValue[index]}"),
                                  );
                                }),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _pageValue.add(_index);
                              print(_pageValue);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
