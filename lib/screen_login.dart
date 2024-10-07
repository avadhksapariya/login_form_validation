import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/bloc/bloc_auth.dart';
import 'package:login_form_validation/palette.dart';
import 'package:login_form_validation/screen_home.dart';
import 'package:login_form_validation/widgets/widget_gradient_button.dart';
import 'package:login_form_validation/widgets/widget_gradient_circular_progress_indicator.dart';
import 'package:login_form_validation/widgets/widget_login_field.dart';
import 'package:login_form_validation/widgets/widget_social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }

          if (state is AuthSuccess) {
            Navigator.of(context)
                .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
          }
        },
        builder: (BuildContext context, AuthState state) {
          if (state is AuthLoading) {
            return RotationTransition(
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
            );
          }
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset('assets/images/signin_balls.png'),
                    const Text(
                      'Sign in.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const SocialButton(iconPath: 'assets/svgs/g_logo.svg', label: 'Continue with Google'),
                    const SizedBox(height: 20),
                    const SocialButton(
                      iconPath: 'assets/svgs/f_logo.svg',
                      label: 'Continue with Facebook',
                      horizontalPadding: 43,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'or',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 15),
                    LoginField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    LoginField(
                      hintText: 'Password',
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),
                    GradientButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
