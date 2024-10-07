import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/bloc/bloc_auth.dart';
import 'package:login_form_validation/palette.dart';
import 'package:login_form_validation/screen_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Form',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Palette.backgroundColor,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
