import 'package:WeduShow/repos/widget_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsViewWidgets {}

class VictorineDialog extends StatefulWidget {
  VictorineDialog({Key key}) : super(key: key);

  @override
  _VictorineDialogState createState() => _VictorineDialogState();
}

class _VictorineDialogState extends State<VictorineDialog> {
  PageController _pageController = PageController(initialPage: 0);
  int _pageViewBuilderIndex;
  List _pageValues = [
    [
      List<TextEditingController>.generate(
          4, (index) => TextEditingController()), // text controllers
      null, // radios group value
      5.00, // slider value
    ],
  ];

  WidgetRepo _widgetRepo = WidgetRepo();

  Color _checkCurrentPage(int index) {
    if (_pageController.position.haveDimensions) {
      if (_pageController.page.toInt() == index) {
        return Colors.black;
      } else {
        return Colors.black12;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
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
                      onPressed: () {
                        _widgetRepo.createNewWidget(_pageValues);
                        Navigator.pop(context);
                      },
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
                  itemCount: _pageValues.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    _pageViewBuilderIndex = index;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _pageValues[index][0][0],
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
                              // Anwsers list view builder
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
                                            controller: _pageValues[
                                                    _pageViewBuilderIndex][0]
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
                                          groupValue:
                                              _pageValues[_pageViewBuilderIndex]
                                                  [1],
                                          onChanged: (T) {
                                            setState(() {
                                              _pageValues[_pageController.page
                                                  .toInt()][1] = T;
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
                              // Anwsers list view builder END
                            ),
                            SizedBox(height: 25),
                            Text("Время на ответ"),
                            Slider(
                              value: _pageValues[index][2],
                              onChanged: (double value) {
                                setState(() {
                                  _pageValues[index][2] = value;
                                });
                              },
                              min: 5,
                              max: 15,
                              divisions: 2,
                              label: "${_pageValues[index][2].toInt()} сек.",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  // Pages horizontal list view builder
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _pageValues.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            setState(() {
                                              _pageController.jumpToPage(index);
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                _pageValues.length == 10
                                                    ? 6.8
                                                    : 6.1),
                                            child: Text(
                                              '${_pageValues.indexOf(_pageValues[index]) + 1}',
                                              // "${_pageValues[index][0]}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: _checkCurrentPage(index),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // Pages horizontal list view builder
                                ),
                                _pageValues.length <= 9
                                    ? Row(
                                        children: <Widget>[
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              _pageValues.add(
                                                [
                                                  List.generate(
                                                      4,
                                                      (index) =>
                                                          TextEditingController()),
                                                  null,
                                                  5.00,
                                                ],
                                              );
                                              _pageController.jumpToPage(
                                                _pageValues.indexOf(
                                                        _pageValues.last) +
                                                    1,
                                              );
                                              setState(() {});
                                            },
                                          ),
                                          _pageValues.length == 1
                                              ? SizedBox()
                                              : IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    _pageValues.removeAt(
                                                        _pageController.page
                                                            .toInt());
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
                                          _pageValues.removeAt(
                                              _pageController.page.toInt());
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
