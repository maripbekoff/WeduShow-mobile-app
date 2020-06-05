part of 'reg_bloc.dart';

abstract class RegEvent extends Equatable {
  const RegEvent();
}

class ButtonPressed extends RegEvent {
  ButtonPressed({this.email, this.password, this.name});

  String email, password, name;

  @override
  // TODO: implement props
  List<Object> get props => null;
}
