import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';

const double _thickness = 0.5;

Widget buildTwoPeopleView(RTCVideoRenderer local, RTCVideoRenderer remote) {
  return Column(
    children: <Widget>[
      Expanded(
        child: RTCVideoView(remote),
      ),
      Divider(
        color: Colors.white,
        height: 0,
        thickness: _thickness,
      ),
      Expanded(
        child: RTCVideoView(local),
      ),
    ],
  );
}

Widget buildThreePeopleView(RTCVideoRenderer local, RTCVideoRenderer remote) {
  return Column(
    children: <Widget>[
      Expanded(
        child: Row(
          children: <Widget>[
            Expanded(
              child: RTCVideoView(remote),
            ),
            VerticalDivider(
              color: Colors.white,
              width: 0,
              thickness: _thickness,
            ),
            Expanded(
              child: RTCVideoView(remote),
            ),
          ],
        ),
      ),
      Divider(
        color: Colors.white,
        height: 0,
        thickness: _thickness,
      ),
      Expanded(
        child: RTCVideoView(local),
      ),
    ],
  );
}

Widget buildFourPeopleView(RTCVideoRenderer local, RTCVideoRenderer remote) {
  return Column(
    children: <Widget>[
      Expanded(
        child: Row(
          children: <Widget>[
            Expanded(
              child: RTCVideoView(remote),
            ),
            VerticalDivider(
              color: Colors.white,
              width: 0,
              thickness: _thickness,
            ),
            Expanded(
              child: RTCVideoView(remote),
            ),
          ],
        ),
      ),
      Divider(
        color: Colors.white,
        height: 0,
        thickness: _thickness,
      ),
      Expanded(
        child: Row(
          children: <Widget>[
            Expanded(
              child: RTCVideoView(local),
            ),
            VerticalDivider(
              color: Colors.white,
              width: 0,
              thickness: _thickness,
            ),
            Expanded(
              child: RTCVideoView(remote),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildFivePeopleView(RTCVideoRenderer local, RTCVideoRenderer remote) {
  return Stack(
    children: <Widget>[
      Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RTCVideoView(remote),
                ),
                VerticalDivider(
                  color: Colors.white,
                  width: 0,
                  thickness: _thickness,
                ),
                Expanded(
                  child: RTCVideoView(remote),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
            height: 0,
            thickness: _thickness,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RTCVideoView(remote),
                ),
                VerticalDivider(
                  color: Colors.white,
                  width: 0,
                  thickness: _thickness,
                ),
                Expanded(
                  child: RTCVideoView(remote),
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
            child: RTCVideoView(local),
          ),
        ),
      ),
    ],
  );
}
