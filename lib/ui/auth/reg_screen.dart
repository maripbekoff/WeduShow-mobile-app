import 'package:Rose/blocs/reg_bloc/reg_bloc.dart';
import 'package:Rose/ui/main_screen.dart';
import 'package:Rose/repos/user_repo.dart';
import 'package:Rose/ui/auth/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegBlocProvider extends StatelessWidget {
  const RegBlocProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegBloc(),
      child: RegScreen(),
    );
  }
}

class RegScreen extends StatelessWidget {
  RegScreen({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  UserRepo userRepo;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegBloc _regBloc = BlocProvider.of<RegBloc>(context);

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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "email"),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(hintText: "password"),
                validator: (val) => val.length < 6 ? 'Too short' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "name"),
                validator: (val) => val.isEmpty ? 'Enter an name' : null,
              ),
              SizedBox(height: 20),
              Container(
                child: BlocListener<RegBloc, RegState>(
                  listener: (BuildContext context, RegState state) {
                    if (state is RegSuccess) {
                      _navToMainScreen(context, state.firebaseUser);
                    } else if (state is RegFailure) {
                      _buildFailureUI(state.error);
                    }
                  },
                  child: BlocBuilder<RegBloc, RegState>(
                      builder: (BuildContext context, RegState state) {
                    if (state is RegInitial) {
                      return _buildInitialUI();
                    } else if (state is RegLoading) {
                      return _buildLoading();
                    } else if (state is RegFailure) {
                      return _buildFailureUI(state.error.toString());
                    } else if (state is RegSuccess) {
                      _emailController.text = '';
                      _passwordController.text = '';
                      _nameController.text = '';
                      return Offstage();
                    }
                  }),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _regBloc
                        ..add(
                          ButtonPressed(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text),
                        );
                    },
                    child: Text("Зарегестрироваться"),
                  ),
                  SizedBox(width: 20),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SignInBlocProvider(),
                        ),
                      );
                    },
                    child: Text("Есть аккаунт?"),
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
