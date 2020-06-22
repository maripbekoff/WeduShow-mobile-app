import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'widget_event.dart';
part 'widget_state.dart';

class WidgetBloc extends Bloc<WidgetEvent, WidgetState> {
  @override
  WidgetState get initialState => WidgetInitial();

  @override
  Stream<WidgetState> mapEventToState(
    WidgetEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
