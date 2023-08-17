import 'package:chat_group_app/bloc/auth_bloc.dart';
import 'package:chat_group_app/screens/chatScreen.dart';
import 'package:chat_group_app/screens/loginScreen.dart';
import 'package:chat_group_app/screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/chat_cubit/chat_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterScreen().id: (context) => RegisterScreen(),
          LoginScreen().id: (context) => LoginScreen(),
          ChatScreen().id: (context) => ChatScreen(),
        },
        initialRoute: LoginScreen().id,
      ),
    );
  }
}
