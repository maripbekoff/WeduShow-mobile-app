import 'dart:ui';

import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
import 'package:Rose/utils/signaling.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/webrtc.dart';

class StreamScreen extends StatefulWidget {
  StreamScreen({
    Key key,
    this.server,
    this.sessionName,
    this.userName,
    this.secret,
    this.iceServer,
  }) : super(key: key);

  final String server;
  final String sessionName;
  final String userName;
  final String secret;
  final String iceServer;

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  final _localRenderer = new RTCVideoRenderer();
  final _remoteRenderer = new RTCVideoRenderer();

  Signaling _signaling;
  CameraController controller;

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

    initRenderers();
  }

  Future<void> initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    _connect();
  }

  void _hangUp() {
    if (_signaling != null) {
      Navigator.of(context).pop();
    }
  }

  void _switchCamera() {
    _signaling.switchCamera();
  }

  void _muteMic() {
    _signaling.muteMic();
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
                // return Container(
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width,
                //   child: RTCVideoView(_localRenderer),
                // );
                return _buildTwoPeopleView(context);
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
                _blocProvider..add(StreamClosed());
                _hangUp();
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
        SizedBox(
          width: 200.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                child: const Icon(Icons.switch_camera),
                onPressed: _switchCamera,
                heroTag: "btn_switchCamera",
              ),
              FloatingActionButton(
                child: const Icon(Icons.mic_off),
                onPressed: _muteMic,
                heroTag: "btn_muteMic",
              ),
            ],
          ),
        ),
        BlocBuilder<StreamBloc, StreamState>(
          builder: (BuildContext context, StreamState state) {
            if (state is StreamInitial) {
              return _buildFloatingActionButton();
            } else {
              return Offstage();
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
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                child: RTCVideoView(_remoteRenderer),
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
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage('assets/person.jpg'),
                  radius: 50,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RTCVideoView(_localRenderer),
        ),
      ],
    );
  }

  Widget _buildThreePeopleView() {
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
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
      ],
    );
  }

  Widget _buildFourPeopleView() {
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
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
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
              child: Transform.scale(
                scale: 2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CameraPreview(controller),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _signaling?.close();
    _localRenderer?.dispose();
    _remoteRenderer?.dispose();
    print('◤◢◤◢◤◢◤◢◤◢◤ dispose() All!!! ◤◢◤◢◤◢◤◢◤◢◤');
    controller?.dispose();
  }

  Future<void> _connect() async {
    if (_signaling == null) {
      // Инициализация Signaling
      _signaling = new Signaling(
        widget.server,
        widget.secret,
        widget.userName,
        widget.iceServer,
      );

      // Создание сессии
      final String sessiondId =
          await _signaling.createWebRtcSession(sessionId: widget.sessionName);
      print('◤◢◤◢◤◢◤◢◤◢◤ sessiondId: $sessiondId  ◤◢◤◢◤◢◤◢◤◢◤');

      // Генерация токена
      final String token =
          await _signaling.createWebRtcToken(sessionId: sessiondId);
      print('◤◢◤◢◤◢◤◢◤◢◤ token: $token  ◤◢◤◢◤◢◤◢◤◢◤');

      // Подключение к WebSocket'у
      await _signaling.connect();

      _signaling.onStateChange = (SignalingState state) {
        print('_signaling.onStateChange: $state');

        switch (state) {
          case SignalingState.CallStateNew:
            break;
          case SignalingState.CallStateBye:
            break;
          default:
            break;
        }
      };

      _signaling.onLocalStream = ((stream) {
        print('onLocalStream: ${stream.id}');
        _localRenderer.srcObject = stream;
      });

      _signaling.onAddRemoteStream = ((stream) {
        print('onAddRemoteStream: ${stream.id}');
        _remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        print('onRemoveRemoteStream');
        _remoteRenderer.srcObject = null;
      });
    }
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
