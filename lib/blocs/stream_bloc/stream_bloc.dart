import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stream_event.dart';
part 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  int index = 0;

  @override
  StreamState get initialState => StreamInitial();

  @override
  Stream<StreamState> mapEventToState(
    StreamEvent event,
  ) async* {
    if (event is ButtonPressed) {
      index += 1;
    }

    if (event is StreamClosed) {
      index = 1;
      yield StreamInitial();
    }

    switch (index) {
      case 1 & 0:
        yield StreamInitial();
        break;
      case 2:
        yield TwoPeopleOnStream();
        break;
      case 3:
        yield ThreePeopleOnStream();
        break;
      case 4:
        yield FourPeopleOnStream();
        break;
      case 5:
        yield FivePeopleOnStream();
        break;
    }
  }
}
