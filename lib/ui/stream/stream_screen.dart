import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
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

  bool _buttonPressed = false;

  List<Color> _listColor = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      cameras[2],
      ResolutionPreset.ultraHigh,
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
                return _buildTwoPeopleView(context);
              } else if (state is ThreePeopleOnStream) {
                return _buildThreePeopleView();
              } else if (state is FourPeopleOnStream) {
                return _buildFourPeopleView();
              } else if (state is FivePeopleOnStream) {
                return _buildFivePeopleView(context);
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
                  _blocProvider..add(ButtonPressed());
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
              return _buildFloatingActionButton();
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
                Text("Викторины")
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _firstView,
              Center(
                child: Text("Виджеты"),
              ),
              Center(
                child: Text("Викторины"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent, width: 4.0),
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(1000.0),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTwoPeopleView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/person.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/person.jpg'),
                      radius: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Барак Обама",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ClipRect(
            child: OverflowBox(
              minHeight: 0.0,
              minWidth: 0.0,
              maxHeight: logicalHeight,
              maxWidth: logicalWidth,
              child: SizedBox(
                width: logicalWidth,
                height: logicalHeight,
                child: CameraPreview(controller),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThreePeopleView() {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: ExactAssetImage('assets/person.jpg'),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: ExactAssetImage('assets/person.jpg'),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ClipRect(
            child: OverflowBox(
              minHeight: 0.0,
              minWidth: 0.0,
              maxHeight: logicalHeight,
              maxWidth: logicalWidth,
              child: SizedBox(
                width: logicalWidth,
                height: logicalHeight,
                child: CameraPreview(controller),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFourPeopleView() {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: ExactAssetImage('assets/person.jpg'),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: ExactAssetImage('assets/person.jpg'),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ClipRect(
                  child: OverflowBox(
                    minHeight: 0.0,
                    minWidth: 0.0,
                    maxHeight: logicalHeight,
                    maxWidth: logicalWidth,
                    child: SizedBox(
                      width: logicalWidth,
                      height: logicalHeight,
                      child: Transform.scale(
                        scale: 0.5,
                        child: CameraPreview(controller),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: ExactAssetImage('assets/person.jpg'),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFivePeopleView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Center(
          child: CircleAvatar(
            radius: 100,
            child: ClipOval(
              child: OverflowBox(
                minHeight: 0.0,
                minWidth: 0.0,
                maxHeight: logicalHeight,
                maxWidth: logicalWidth,
                child: SizedBox(
                  width: logicalWidth,
                  height: logicalHeight,
                  child: Transform.scale(
                    scale: 0.5,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TwoPeopleViewClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addRect(
      Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
