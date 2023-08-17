part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterSuccess extends AuthState {
  String? SuccessMSG;

  RegisterSuccess({required SuccessMSG});
}

class RegisterLoading extends AuthState {}

class RegisterFailure extends AuthState {
  String? errorMsg;

  RegisterFailure({required errorMsg});
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  String? errorMsg;

  LoginFailure({required errorMsg});
}
