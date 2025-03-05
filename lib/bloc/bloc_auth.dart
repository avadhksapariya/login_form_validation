import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_auth_event.dart';
part 'bloc_auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);

    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  // Added Bloc Observer for this.
  /*@override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    log('AuthBlock change: $change');
  }*/

  // onTransition: only available in Bloc, not in Cubit
  // as Cubit works on what function was called instead of an event.
  // Transition (is called) happens before the change occur.
  /*@override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    log('AuthBlock transition: $transition');
  }*/

  void _onAuthLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
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
          return emit(AuthSuccess(uid: email.split('@').first));
        },
      );
    } on Exception catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(AuthInitial());
        },
      );
    } on Exception catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }
}

/*

- onTransition and onChange are useful to identify the event that caused the state change.
- This is useful in some cases and there is necessary to use Bloc instead of Cubit.

> Another area where Bloc can shine...
  - When we want to add advanced event transformation.
  - When we want to take advantage of the reactive operators
      i.e. buffer, debounce time, throttle etc.
  - In such cases Cubit cannot be used.

  - debounce time : A way of delaying the execution of a function until certain amount of time is passed.
  - To know more about event transformation another package: bloc_concurrency

*/
