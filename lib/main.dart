import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/app_bloc_observer.dart';
import 'package:login_form_validation/bloc/bloc_auth.dart';
import 'package:login_form_validation/firebase_options.dart';
import 'package:login_form_validation/presentation/palette.dart';
import 'package:login_form_validation/presentation/screens/screen_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
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
