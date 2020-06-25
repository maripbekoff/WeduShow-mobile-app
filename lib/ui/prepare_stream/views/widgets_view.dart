import 'package:WeduShow/ui/prepare_stream/widgets/widgets_view_widgets.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WidgetsView extends StatefulWidget {
  WidgetsView({Key key, this.cameraController}) : super(key: key);
  CameraController cameraController;

  @override
  _WidgetsViewState createState() =>
      _WidgetsViewState(cameraController: cameraController);
}

class _WidgetsViewState extends State<WidgetsView> {
  _WidgetsViewState({this.cameraController});
  CameraController cameraController;
  WidgetsViewWidgets _viewWidgets = WidgetsViewWidgets();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: CameraPreview(cameraController),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 25),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      iconSize: 25,
                      icon: Image.asset('assets/icon_01.png'),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      iconSize: 42.5,
                      icon: Image.asset('assets/icon_02.png'),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => VictorineDialog(),
                        );
                      },
                      iconSize: 55,
                      icon: Image.asset('assets/icon_03.png'),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      iconSize: 42.5,
                      icon: Image.asset('assets/icon_04.png'),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      iconSize: 25,
                      icon: Image.asset('assets/icon_05.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
