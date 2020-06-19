import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
import 'package:Rose/ui/prepare_stream/views/list_of_people.dart';
import 'package:Rose/ui/prepare_stream/widgets/guests_view_widgets.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestView extends StatefulWidget {
  GuestView({Key key, this.cameraController}) : super(key: key);
  CameraController cameraController;

  @override
  _GuestViewState createState() =>
      _GuestViewState(cameraController: cameraController);
}

class _GuestViewState extends State<GuestView> {
  _GuestViewState({this.cameraController});
  CameraController cameraController;

  GuestViewWidgets _peopleValueUI = GuestViewWidgets();

  @override
  Widget build(BuildContext context) {
    StreamBloc _blocProvider = BlocProvider.of<StreamBloc>(context);

    return Stack(
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
                  child: AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
                  ),
                );
              } else if (state is TwoPeopleOnStream) {
                return _peopleValueUI.buildTwoPeopleView(
                  context,
                  cameraController,
                );
              } else if (state is ThreePeopleOnStream) {
                return _peopleValueUI.buildThreePeopleView(
                    context, cameraController);
              } else if (state is FourPeopleOnStream) {
                return _peopleValueUI.buildFourPeopleView(
                    context, cameraController);
              } else if (state is FivePeopleOnStream) {
                return _peopleValueUI.buildFivePeopleView(
                    context, cameraController);
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
  }
}
