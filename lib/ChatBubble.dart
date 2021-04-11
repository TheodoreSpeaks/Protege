import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const ChatBubble({required this.text, this.isUser = true}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      isUser ? Spacer() : Container(),
      Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 14, right: 14, top: 14),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: isUser ? Radius.circular(20) : Radius.circular(0),
              bottomRight: !isUser ? Radius.circular(20) : Radius.circular(0)),
          color: isUser ? Colors.blue : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(color: isUser ? Colors.white : Colors.blue),
        ),
      ),
      !isUser ? Spacer() : Container(),
    ]);
  }
}
