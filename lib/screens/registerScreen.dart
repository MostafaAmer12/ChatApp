import 'package:chat_group_app/bloc/auth_bloc.dart';
import 'package:chat_group_app/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/button.dart';
import '../components/snackBar.dart';
import '../components/textField.dart';
import '../cubit/chat_cubit/chat_cubit.dart';
import 'chatScreen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  String id = 'Register Screen';
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen().id, arguments: email);
          isLoading = false;
        } else if (state is RegisterFailure) {
          isLoading = false;
          return showSnackBar(context, state.errorMsg!);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                          'Register',
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
                      text: 'Sign Up',
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                              email: email!, password: password!));
                        }
                      },
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login Now',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Pacifico'),
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
        );
      },
    );
  }
}
