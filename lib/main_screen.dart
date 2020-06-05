import 'package:Rose/repos/user_repo.dart';
import 'package:Rose/ui/auth/sign_in_screen.dart';
import 'package:Rose/ui/stream/stream_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  UserRepo _userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => StreamScreen(),
                  ),
                );
              },
              color: Colors.orange,
              child: Text(
                "Запустить эфир",
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                await _userRepo.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SignInBlocProvider(),
                  ),
                );
              },
              color: Colors.orange,
              child: Text(
                "Выйти из профиля",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
