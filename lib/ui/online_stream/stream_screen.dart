import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
import 'package:Rose/utils/signaling.dart';
import 'widgets/people_value_ui.dart';
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

  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  Future<void> initRenderers() async {
    _localRenderer.mirror = false;
    _localRenderer.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
    _remoteRenderer.objectFit =
        RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
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

    return SafeArea(
      child: Stack(
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
                    child: RTCVideoView(_localRenderer),
                  );
                } else if (state is TwoPeopleOnStream) {
                  return buildTwoPeopleView(_localRenderer, _remoteRenderer);
                } else if (state is ThreePeopleOnStream) {
                  return buildThreePeopleView(_localRenderer, _remoteRenderer);
                } else if (state is FourPeopleOnStream) {
                  return buildFourPeopleView(_localRenderer, _remoteRenderer);
                } else if (state is FivePeopleOnStream) {
                  return buildFivePeopleView(_localRenderer, _remoteRenderer);
                }
              },
            ),
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                _blocProvider..add(StreamClosed());
                _hangUp();
                Future.delayed(const Duration(seconds: 1),
                    () => _blocProvider..add(StreamClosed()));
              },
              icon: Stack(
                children: <Widget>[
                  Positioned(
                    top: 3,
                    left: 2,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black38,
                    ),
                  ),
                  Icon(Icons.arrow_back),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 3,
                      left: 2,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black38,
                      ),
                    ),
                    Icon(Icons.menu),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
          ),
        ],
      ),
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
