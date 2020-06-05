part of 'stream_bloc.dart';

abstract class StreamEvent extends Equatable {
  const StreamEvent();
}

class ButtonPressed extends StreamEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
