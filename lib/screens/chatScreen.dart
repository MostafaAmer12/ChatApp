import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/chatBubble.dart';
import '../components/constants.dart';
import '../cubit/chat_cubit/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  String id = 'ChatScreen';
  TextEditingController textController = TextEditingController();
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    String? message;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 38,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(
                              message: messagesList[index],
                            );
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              onChanged: (data) {
                message = data;
              },
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessages(message: data, email: email);
                textController.clear();
                controller.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessages(message: message, email: email);
                    textController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
