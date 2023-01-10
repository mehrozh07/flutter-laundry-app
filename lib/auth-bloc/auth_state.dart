part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState{}

class AuthLoggedInState extends AuthState{
  User? user;
  AuthLoggedInState(this.user);
}

class AuthCodeSendState extends AuthState{}

class AuthVerifyCodeState extends AuthState{}

class AuthLogOutState extends AuthState{}

class ErrorState extends AuthState{
  String? error;
  ErrorState(this.error);
}