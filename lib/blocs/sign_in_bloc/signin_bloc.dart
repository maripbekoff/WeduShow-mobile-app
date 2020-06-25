import 'dart:async';

import 'package:WeduShow/repos/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() {
    this.userRepo;
  }

  UserRepo userRepo = UserRepo();

  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is ButtonPressed) {
      try {
        yield SignInLoading();
        var user = await userRepo.signIn(event.email, event.password);
        yield SignInSuccess(user: user);
      } catch (e) {
        yield SignInFailure(error: e.toString());
      }
    }
  }
}
