import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsViewWidgets {}

class VictorineDialog extends StatefulWidget {
  VictorineDialog({Key key}) : super(key: key);

  @override
  _VictorineDialogState createState() => _VictorineDialogState();
}

class _VictorineDialogState extends State<VictorineDialog> {
  PageController _pageController = PageController();
  List _textContollers = List.generate(
      1, (index) => List.generate(4, (index) => TextEditingController()));
  int _groupValue;
  double _sliderValue = 5;
  int _listViewBuilderIndex;
  int _pageViewBuilderIndex;
  List<int> _pageValue = [1];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
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
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pageValue.length,
                  itemBuilder: (BuildContext context, int index) {
                    _pageViewBuilderIndex = index;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _textContollers[index][0],
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
                                itemCount: 3,
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
                                            controller: _textContollers[
                                                    _pageViewBuilderIndex]
                                                [index + 1],
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
                                separatorBuilder:
                                    (BuildContext context, int index) =>
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
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _pageValue.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      _listViewBuilderIndex = index + 2;
                                      return Center(
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                _pageValue.length == 10
                                                    ? 6.8
                                                    : 6.1),
                                            // 9 - 6.8
                                            // ...10 - 6.1
                                            child: Text(
                                              "${_pageValue[index]}",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                _pageValue.length <= 9
                                    ? Row(
                                        children: <Widget>[
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              _pageValue.add(index + 2);
                                              print(_pageValue);
                                              setState(() {});
                                            },
                                          ),
                                          _pageValue.length == 1
                                              ? SizedBox()
                                              : IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    _pageValue.removeLast();
                                                    print(_pageValue);
                                                    setState(() {});
                                                  },
                                                ),
                                        ],
                                      )
                                    : IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          _pageValue.removeLast();
                                          print(_pageValue);
                                          setState(() {});
                                        },
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
