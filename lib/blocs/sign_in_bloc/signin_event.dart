part of 'signin_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class ButtonPressed extends SignInEvent {
  ButtonPressed({@required this.email, @required this.password});
  String email, password;

  @override
  List<Object> get props => null;
}
