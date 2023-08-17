import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    @override
    void onTransition(Transition<AuthEvent, AuthState> transition) {
      super.onTransition(transition);
      print(transition);
    }

    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          print(e);
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errorMsg: 'user-not-found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errorMsg: 'wrong-password'));
          }
        } catch (e) {
          emit(LoginFailure(errorMsg: 'Something went wrong'));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(RegisterSuccess(SuccessMSG: 'Account already exist'));
        } on FirebaseAuthException catch (e) {
          print(e);
          if (e.code == 'weak-password') {
            emit(RegisterFailure(errorMsg: 'weak-password'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(errorMsg: 'Account already exist'));
          }
        } catch (e) {
          emit(RegisterFailure(errorMsg: 'Something went wrong'));
        }
      }
    });
  }
}
