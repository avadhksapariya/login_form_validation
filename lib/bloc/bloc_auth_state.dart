part of 'bloc_auth.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess({required this.uid});
  final String uid;
}

final class AuthGoogleSignInSuccess extends AuthState {
  final String email;

  AuthGoogleSignInSuccess({required this.email});
}

final class AuthFacebookSignInSuccess extends AuthState {
  final ModelFacebookAuth? userData;

  AuthFacebookSignInSuccess({required this.userData});
}

final class AuthFailure extends AuthState {
  AuthFailure(this.error);

  final String error;
}

final class AuthLoading extends AuthState {}

final class AuthGoogleLoading extends AuthState {}

final class AuthFacebookLoading extends AuthState {}
