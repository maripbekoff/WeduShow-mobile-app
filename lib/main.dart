import 'package:Rose/blocs/auth_bloc/auth_bloc.dart';
import 'package:Rose/blocs/stream_bloc/stream_bloc.dart';
import 'package:Rose/main_screen.dart';
import 'package:Rose/ui/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc()..add(AppStart()),
        ),
        BlocProvider(
          create: (BuildContext context) => StreamBloc()..add(ButtonPressed()),
        ),
      ],
      child: MaterialApp(
        title: 'Rose',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is AuthInitial) {
          return SignInBlocProvider();
        } else if (state is Autheticated) {
          return MainScreen();
        } else if (state is UnAutheticated) {
          return SignInBlocProvider();
        }
      },
    );
  }
}
