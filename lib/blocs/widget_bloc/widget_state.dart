part of 'widget_bloc.dart';

abstract class WidgetState extends Equatable {
  const WidgetState();
}

class WidgetInitial extends WidgetState {
  @override
  List<Object> get props => [];
}
