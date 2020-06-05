import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
