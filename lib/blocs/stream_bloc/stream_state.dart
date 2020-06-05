part of 'stream_bloc.dart';

abstract class StreamState extends Equatable {
  const StreamState();
}

class StreamInitial extends StreamState {
  @override
  List<Object> get props => [];
}

class TwoPeopleOnStream extends StreamState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ThreePeopleOnStream extends StreamState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FourPeopleOnStream extends StreamState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
