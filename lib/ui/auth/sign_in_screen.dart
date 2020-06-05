import 'package:Rose/blocs/sign_in_bloc/signin_bloc.dart';
import 'package:Rose/repos/user_repo.dart';
import 'package:Rose/main_screen.dart';
import 'package:Rose/ui/auth/reg_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBlocProvider extends StatelessWidget {
  SignInBlocProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignInBloc(),
      child: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  SignInScreen({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  UserRepo userRepo = UserRepo();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignInBloc _signInBloc = BlocProvider.of<SignInBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "email"),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(hintText: "password"),
                validator: (val) => val.length < 6 ? 'Enter an password' : null,
              ),
              SizedBox(height: 20),
              Container(
                child: BlocListener<SignInBloc, SignInState>(
                  listener: (BuildContext context, SignInState state) {
                    if (state is SignInSuccess) {
                      _navToMainScreen(context, state.user);
                    } else if (state is SignInFailure) {
                      _buildFailureUI(state.error);
                    }
                  },
                  child: BlocBuilder<SignInBloc, SignInState>(
                    builder: (BuildContext context, SignInState state) {
                      if (state is SignInInitial) {
                        return _buildInitialUI();
                      } else if (state is SignInLoading) {
                        return _buildLoading();
                      } else if (state is SignInFailure) {
                        return _buildFailureUI(state.error.toString());
                      } else if (state is SignInSuccess) {
                        _emailController.text = '';
                        _passwordController.text = '';
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      _signInBloc
                        ..add(
                          ButtonPressed(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                    },
                    child: Text("Войти"),
                  ),
                  SizedBox(width: 20),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => RegBlocProvider(),
                        ),
                      );
                    },
                    child: Text("Нет аккаунта?"),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navToMainScreen(BuildContext context, FirebaseUser user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MainScreen(),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildFailureUI(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget _buildInitialUI() {
    return Center(
      child: Text("Вход в систему"),
    );
  }
}
