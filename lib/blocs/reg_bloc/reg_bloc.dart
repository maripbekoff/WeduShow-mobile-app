import 'dart:async';

import 'package:WeduShow/repos/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'reg_event.dart';
part 'reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  UserRepo userRepo;

  RegBloc() {
    this.userRepo = UserRepo();
  }

  @override
  RegState get initialState => RegInitial();

  @override
  Stream<RegState> mapEventToState(
    RegEvent event,
  ) async* {
    if (event is ButtonPressed) {
      try {
        yield RegLoading();
        var user =
            await userRepo.regNewUser(event.email, event.password, event.name);
        yield RegSuccess(
            user: user, firebaseUser: await userRepo.getCurrentUser());
      } catch (e) {
        yield RegFailure(error: e.toString());
      }
    }
  }
}
