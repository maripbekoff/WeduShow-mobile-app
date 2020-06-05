import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamScreen extends StatelessWidget {
  StreamScreen({Key key}) : super(key: key);

  List<Color> _listColor = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    StreamBloc _blocProvider = BlocProvider.of<StreamBloc>(context);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _blocProvider..add(ButtonPressed());
          },
          child: Icon(Icons.add),
        ),
        body: BlocBuilder<StreamBloc, StreamState>(
          builder: (BuildContext context, StreamState state) {
            if (state is StreamInitial) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: _listColor[0],
              );
            } else if (state is TwoPeopleOnStream) {
              return _buildTwoPeopleView();
            } else if (state is ThreePeopleOnStream) {
              return _buildThreePeopleView();
            } else if (state is FourPeopleOnStream) {
              return _buildFourPeopleView();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTwoPeopleView() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: _listColor[0],
          ),
        ),
        Expanded(
          child: Container(
            color: _listColor[1],
          ),
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
                child: Container(
                  color: _listColor[0],
                ),
              ),
              Expanded(
                child: Container(
                  color: _listColor[1],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: _listColor[2],
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
                child: Container(
                  color: _listColor[0],
                ),
              ),
              Expanded(
                child: Container(
                  color: _listColor[1],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: _listColor[2],
                ),
              ),
              Expanded(
                child: Container(
                  color: _listColor[3],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
