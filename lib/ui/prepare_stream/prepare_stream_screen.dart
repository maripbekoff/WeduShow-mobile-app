import 'package:Rose/main.dart';
import 'package:Rose/ui/prepare_stream/views/guests_view.dart';
import 'package:Rose/ui/prepare_stream/views/widgets_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PrepareStreamScreen extends StatefulWidget {
  PrepareStreamScreen({Key key}) : super(key: key);

  @override
  _PrepareStreamScreenState createState() => _PrepareStreamScreenState();
}

class _PrepareStreamScreenState extends State<PrepareStreamScreen> {
  CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(
      cameras.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.front),
      ResolutionPreset.max,
      enableAudio: false,
    );

    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  // Future<void> _initCamera(CameraDescription description) async {
  //   _cameraController =
  //       CameraController(description, ResolutionPreset.max, enableAudio: false);
  // }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     final lensDirection = _cameraController.description.lensDirection;
          //     CameraDescription newDescription;
          //     lensDirection == CameraLensDirection.front
          //         ? newDescription = cameras.firstWhere((element) =>
          //             element.lensDirection == CameraLensDirection.back)
          //         : newDescription = cameras.firstWhere((description) =>
          //             description.lensDirection == CameraLensDirection.front);
          //     newDescription != null
          //         ? setState(() {
          //             _cameraController = CameraController(
          //               newDescription,
          //               ResolutionPreset.max,
          //               enableAudio: false,
          //             );
          //           })
          //         : print('error');
          //   },
          //   child: Icon(Icons.switch_camera),
          // ),
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
              GuestView(cameraController: _cameraController),
              WidgetsView(cameraController: _cameraController),
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
