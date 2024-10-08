import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_auth_event.dart';
part 'bloc_auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final email = event.email;
        final password = event.password;

        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) != true) {
          emit(AuthFailure('Kindly add valid email address.'));
          return;
        }

        if (password.length < 6) {
          return emit(AuthFailure('Password cannot be less than 6 characters.'));
        }

        await Future.delayed(
          const Duration(seconds: 1),
          () {
            return emit(AuthSuccess(uid: '${email.split('.').first}-$password'));
          },
        );
      } on Exception catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    });
  }
}
