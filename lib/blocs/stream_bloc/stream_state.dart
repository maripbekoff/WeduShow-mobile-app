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
  List<Object> get props => null;
}

class ThreePeopleOnStream extends StreamState {
  @override
  List<Object> get props => null;
}

class FourPeopleOnStream extends StreamState {
  @override
  List<Object> get props => null;
}

class FivePeopleOnStream extends StreamState {
  @override
  List<Object> get props => throw UnimplementedError();
}
