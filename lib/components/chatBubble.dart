import 'package:chat_group_app/components/constants.dart';
import 'package:chat_group_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/message.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({Key? key, required this.message}) : super(key: key);
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Text(
                message.id,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: DottedLine(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                lineLength: 180,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Colors.black,
                dashGradient: [Colors.red, Colors.blue],
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapGradient: [Colors.red, Colors.blue],
                dashGapRadius: 0.0,
              ),
            ),
            Text(
              message.message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({Key? key, required this.message}) : super(key: key);
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff006D84),
              ),
              child: Text(
                message.id,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: DottedLine(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                lineLength: 180,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Colors.black,
                dashGradient: [Colors.red, Colors.blue],
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapGradient: [Colors.red, Colors.blue],
                dashGapRadius: 0.0,
              ),
            ),
            Text(
              message.message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
