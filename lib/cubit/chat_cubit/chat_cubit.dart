import 'package:bloc/bloc.dart';
import 'package:chat_group_app/components/constants.dart';
import 'package:chat_group_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagesList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessengerCollection);

  void sendMessages({required message, required email}) {
    messages.add({
      'message': message,
      'createdAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        print(Message.fromJson(doc));
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }

  @override
  void onChange(Change<ChatState> change) {
    super.onChange(change);
    print(change);
  }
}
