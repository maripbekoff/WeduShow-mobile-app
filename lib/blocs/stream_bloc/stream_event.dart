part of 'stream_bloc.dart';

abstract class StreamEvent extends Equatable {
  const StreamEvent();
}

class ButtonPressed extends StreamEvent {
  @override
  List<Object> get props => null;
}

class StreamClosed extends StreamEvent {
  @override
  List<Object> get props => null;
}
