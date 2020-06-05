part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStart extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
