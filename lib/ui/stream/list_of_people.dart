import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeopleList extends StatelessWidget {
  PeopleList({Key key}) : super(key: key);

  TextEditingController _searchContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StreamBloc _blocProvider = BlocProvider.of<StreamBloc>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _searchContoller,
                decoration: InputDecoration(
                  hintText: "Поиск",
                  hintStyle: TextStyle(color: Color(0xFFA8A8A8)),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFA8A8A8),
                    size: 20,
                  ),
                  fillColor: Color(0xFFE5E5E5),
                  contentPadding: EdgeInsets.all(10),
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 123,
              color: Colors.white,
              child: ListView.separated(
                padding: EdgeInsets.all(15),
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    type: MaterialType.button,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _blocProvider..add(ButtonPressed());
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 35,
                          ),
                          SizedBox(height: 5),
                          Text("Name"),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: 20),
              ),
            ),
            SizedBox(height: 5),
            Container(
              color: Colors.white,
              child: ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 40,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      onTap: () {
                        _blocProvider..add(ButtonPressed());
                        Navigator.pop(context);
                      },
                      leading: CircleAvatar(
                        backgroundImage: ExactAssetImage('assets/person.jpg'),
                      ),
                      title: Text("Name"),
                      trailing: ClipOval(
                        child: Material(
                          type: MaterialType.button,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () async {
                              _blocProvider..add(ButtonPressed());
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
