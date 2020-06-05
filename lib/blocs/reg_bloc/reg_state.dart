part of 'reg_bloc.dart';

abstract class RegState extends Equatable {
  const RegState();
}

class RegInitial extends RegState {
  @override
  List<Object> get props => [];
}

class RegLoading extends RegState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RegSuccess extends RegState {
  RegSuccess({this.user, this.firebaseUser});

  AuthResult user;
  FirebaseUser firebaseUser;

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RegFailure extends RegState {
  RegFailure({this.error});

  String error;

  @override
  // TODO: implement props
  List<Object> get props => null;
}
