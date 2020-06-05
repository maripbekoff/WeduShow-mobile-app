part of 'signin_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SignInSuccess extends SignInState {
  SignInSuccess({this.user});

  FirebaseUser user;

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SignInFailure extends SignInState {
  SignInFailure({this.error});

  String error;

  @override
  // TODO: implement props
  List<Object> get props => null;
}
