part of 'bloc_auth.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  AuthLoginRequested({required this.email, required this.password});

  final String email;
  final String password;
}

final class AuthGoogleSignInRequested extends AuthEvent {}

final class AuthGoogleSignOutRequested extends AuthEvent {}

final class AuthLogoutRequested extends AuthEvent {}
