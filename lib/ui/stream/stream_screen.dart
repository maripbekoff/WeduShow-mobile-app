import 'dart:ui';
import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
import 'package:Rose/ui/stream/list_of_people.dart';
import 'widgets/people_value_ui.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class StreamScreen extends StatefulWidget {
  StreamScreen({Key key}) : super(key: key);

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      cameras[2],
      ResolutionPreset.veryHigh,
    );

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StreamBloc _blocProvider = BlocProvider.of<StreamBloc>(context);

    PeopleValueUI _peopleValueUI = PeopleValueUI();

    Widget _firstView = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<StreamBloc, StreamState>(
            builder: (BuildContext context, StreamState state) {
              if (state is StreamInitial) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CameraPreview(controller),
                );
              } else if (state is TwoPeopleOnStream) {
                return _peopleValueUI.buildTwoPeopleView(context, controller);
              } else if (state is ThreePeopleOnStream) {
                return _peopleValueUI.buildThreePeopleView(context, controller);
              } else if (state is FourPeopleOnStream) {
                return _peopleValueUI.buildFourPeopleView(context, controller);
              } else if (state is FivePeopleOnStream) {
                return _peopleValueUI.buildFivePeopleView(context, controller);
              }
            },
          ),
        ),
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {},
            icon: Stack(
              children: <Widget>[
                Positioned(
                  top: 3,
                  left: 2,
                  child: Icon(
                    Icons.settings,
                    color: Colors.black38,
                  ),
                ),
                Icon(Icons.settings),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                Future.delayed(const Duration(seconds: 1),
                    () => _blocProvider..add(StreamClosed()));
              },
              icon: Stack(
                children: <Widget>[
                  Positioned(
                    top: 3,
                    left: 2,
                    child: Icon(
                      Icons.close,
                      color: Colors.black38,
                    ),
                  ),
                  Icon(Icons.close),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(1000.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PeopleList(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 3,
                        left: 2,
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.black38,
                        ),
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<StreamBloc, StreamState>(
          builder: (BuildContext context, StreamState state) {
            if (state is StreamInitial) {
              return _peopleValueUI.buildFloatingActionButton();
            } else {
              return Container();
            }
          },
        ),
      ],
    );

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Material(
            color: Colors.black,
            child: TabBar(
              labelColor: Colors.white,
              labelPadding: EdgeInsets.all(10),
              unselectedLabelColor: Colors.white38,
              indicatorColor: Colors.transparent,
              tabs: <Widget>[
                Text("Участники"),
                Text("Виджеты"),
                Text("Настройки")
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              _firstView,
              Center(
                child: Text("Виджеты"),
              ),
              Center(
                child: Text("Настройки"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
