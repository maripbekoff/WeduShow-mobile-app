import 'dart:async';
import 'dart:io';

import 'package:WeduShow/repos/user_repo.dart';
import 'package:WeduShow/ui/auth/sign_in_screen.dart';
import 'package:WeduShow/ui/online_stream/stream_screen.dart';
import 'package:WeduShow/ui/prepare_stream/prepare_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserRepo _userRepo = UserRepo();

  bool isOnline = false;
  TextEditingController _textSessionController;
  TextEditingController _textUserNameController;
  TextEditingController _textUrlController;
  TextEditingController _textSecretController;
  TextEditingController _textPortController;
  TextEditingController _textIceServersController;

  @override
  void initState() {
    super.initState();

    _textSessionController = TextEditingController(text: 'SessionA');
    _textUserNameController = TextEditingController(text: 'Hello');
    _textUrlController = TextEditingController(text: 'codeunion.kz');
    _textSecretController = TextEditingController(text: 'codeunion_roze2020');
    _textPortController = TextEditingController(text: '443');
    _textIceServersController = TextEditingController(text: 'codeunion.kz');

    _loadSharedPref();
    _liveConn();
  }

  Future<void> _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _textUrlController.text =
        prefs.getString('textUrl') ?? _textUrlController.text;
    _textSecretController.text =
        prefs.getString('textSecret') ?? _textSecretController.text;
    _textPortController.text =
        prefs.getString('textPort') ?? _textPortController.text;
    _textIceServersController.text =
        prefs.getString('textIceServers') ?? _textIceServersController.text;
    print('Загрузка данных пользователя.');
  }

  Future<void> _saveSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('textUrl', _textUrlController.text);
    await prefs.setString('textSecret', _textSecretController.text);
    await prefs.setString('textPort', _textPortController.text);
    await prefs.setString('textIceServers', _textIceServersController.text);
    print('Данные пользователя были загружены.');
  }

  Future<void> _liveConn() async {
    await _checkOnline();
    Timer.periodic(Duration(seconds: 5), (timer) async {
      await _checkOnline();
    });
  }

  Future<void> _checkOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!isOnline) {
          isOnline = true;
          setState(() {});
          print('Онлайн..');
        }
      }
    } on SocketException catch (_) {
      if (isOnline) {
        isOnline = false;
        setState(() {});
        print('..Оффлайн');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textSessionController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(),
                labelText: 'Название комнаты',
                hintText: 'Введите название сессии..',
              ),
            ),
            TextField(
              controller: _textUserNameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(),
                labelText: 'Никнейм',
                hintText: 'Введите никнейм',
              ),
            ),
            RaisedButton(
              onPressed: isOnline
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            _saveSharedPref();
                            return StreamScreen(
                              server:
                                  '${_textUrlController.text}:${_textPortController.text}',
                              sessionName: _textSessionController.text,
                              userName: _textUserNameController.text,
                              secret: _textSecretController.text,
                              iceServer: _textIceServersController.text,
                            );
                          },
                        ),
                      )
                  : null,
              color: Colors.orange,
              disabledColor: Colors.grey,
              child: isOnline
                  ? Text(
                      "Запустить эфир",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Оффлайн',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PrepareStreamScreen(),
                  ),
                );
              },
              child: Text("Подготовить эфир"),
              color: Colors.orange,
              textColor: Colors.white,
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
