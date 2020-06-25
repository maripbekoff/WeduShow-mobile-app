import 'dart:async';

import 'package:WeduShow/repos/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepo userRepo;

  AuthBloc() {
    this.userRepo = UserRepo();
  }

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStart) {
      try {
        var isSignedIn = await userRepo.isSignedIn();
        if (isSignedIn) {
          var user = await userRepo.getCurrentUser();
          yield Autheticated(firebaseUser: user);
        } else {
          yield UnAutheticated();
        }
      } catch (e) {
        yield UnAutheticated();
      }
    }
  }
}
