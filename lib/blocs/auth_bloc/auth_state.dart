part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUninit extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Autheticated extends AuthState {
  FirebaseUser firebaseUser;

  Autheticated({this.firebaseUser});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UnAutheticated extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AuthLoading extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
