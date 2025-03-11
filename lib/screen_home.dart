import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/bloc/bloc_auth.dart';
import 'package:login_form_validation/palette.dart';
import 'package:login_form_validation/screen_login.dart';
import 'package:login_form_validation/widgets/widget_gradient_button.dart';
import 'package:login_form_validation/widgets/widget_gradient_circular_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late Animation<double> cpIndAnimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    cpIndAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() => setState(() {}));
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          if (state is AuthLoading || state is AuthGoogleLoading || state is AuthFacebookLoading) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: RotationTransition(
                  turns: cpIndAnimation,
                  child: const GradientCircularProgressIndicator(
                    radius: 20,
                    gradientColors: [
                      Palette.gradient1,
                      Palette.gradient2,
                      Palette.gradient3,
                    ],
                    strokeWidth: 6.0,
                  ),
                ),
              ),
            );
          } else if (state is AuthSuccess || state is AuthGoogleSignInSuccess || state is AuthFacebookSignInSuccess) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is AuthSuccess) Text('Welcome ${state.uid} !'),
                  if (state is AuthGoogleSignInSuccess) Text('Welcome ${state.email} !'),
                  if (state is AuthFacebookSignInSuccess) Text('Welcome ${state.userData!['name']} !'),
                  const Spacer(),
                  GradientButton(
                    onPressed: () {
                      if (state is AuthSuccess) {
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                      } else if (state is AuthGoogleSignInSuccess) {
                        context.read<AuthBloc>().add(AuthGoogleSignOutRequested());
                      } else if (state is AuthFacebookSignInSuccess) {
                        context.read<AuthBloc>().add(AuthFacebookSignOutRequested());
                      }
                    },
                    title: 'Sign out',
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}
