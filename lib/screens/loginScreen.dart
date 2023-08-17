import 'package:chat_group_app/bloc/auth_bloc.dart';
import 'package:chat_group_app/components/button.dart';
import 'package:chat_group_app/components/constants.dart';
import 'package:chat_group_app/components/textField.dart';
import 'package:chat_group_app/screens/chatScreen.dart';
import 'package:chat_group_app/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/snackBar.dart';
import '../cubit/chat_cubit/chat_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  String id = 'Login Screen';

  String? email;
  GlobalKey<FormState> formKey = GlobalKey();
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen().id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          isLoading = false;
          return showSnackBar(context, state.errorMsg!);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Spacer(
                    flex: 10,
                  ),
                  Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        kLogo,
                        fit: BoxFit.fill,
                      )),
                  Spacer(
                    flex: 1,
                  ),
                  const Text(
                    'Group Chat',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextField(
                    label: 'Email',
                    onchanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultTextField(
                    label: 'Password',
                    obsecure: true,
                    onchanged: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      text: 'Sign In',
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(email: email!, password: password!));
                        }
                      }),
                  Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen().id);
                          },
                          child: const Text(
                            'Register Now',
                            style:
                                TextStyle(fontSize: 15, fontFamily: 'Pacifico'),
                          ))
                    ],
                  ),
                  Spacer(
                    flex: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
