part of 'bloc_auth.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess({required this.uid});
  final String uid;
}

final class AuthFailure extends AuthState {
  AuthFailure(this.error);

  final String error;
}

final class AuthLoading extends AuthState {}
