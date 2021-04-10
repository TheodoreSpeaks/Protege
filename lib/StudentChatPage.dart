import 'package:flutter/material.dart';

class StudentChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assignment 3: Induction',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text('due Wednesday, April 4, 2021',
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic)),
                    Text('10 points', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 16),
                    Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: () {},
                          label: Text('Submit'),
                          icon: Icon(Icons.check),
                        ),
                      ],
                    )
                  ],
                )),
          ),
          Expanded(flex: 2, child: ChatPage()),
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _message_controller;
  String old_value;

  @override
  void initState() {
    super.initState();
    _message_controller = TextEditingController();
    old_value = '';
  }

  @override
  void dispose() {
    _message_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ChatBubble(
                  text:
                      'hello well learn about induction today. What do you know about induction?'),
              ChatBubble(
                  text: 'I dont know much, what is induction?', isUser: false),
              ChatBubble(text: 'Induction starts with three steps'),
              ChatBubble(text: 'ok', isUser: false),
              ChatBubble(text: 'Induction starts with three steps'),
              ChatBubble(text: 'ok', isUser: false),
              ChatBubble(text: 'Induction starts with three steps'),
              ChatBubble(text: 'ok', isUser: false),
              ChatBubble(text: 'Induction starts with three steps'),
              ChatBubble(text: 'ok', isUser: false),
              ChatBubble(text: 'Induction starts with three steps'),
              ChatBubble(text: 'ok', isUser: false),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(icon: Icon(Icons.mic), onPressed: () {}),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all()),
                child: TextField(
                  controller: _message_controller,
                  onChanged: (str) {
                    // SO JANK DOESNT DELETE PROPERLY
                    final val = TextSelection.collapsed(
                        offset: _message_controller.text.length);
                    _message_controller.selection = val;

                    String fixed_text;
                    print('old value $old_value, new value $str');
                    if (str.length > old_value.length) {
                      // Add new text
                      fixed_text =
                          (str.length != 0) ? str.substring(1) + str[0] : '';
                    } else {
                      fixed_text = old_value.substring(0, old_value.length - 1);
                    }

                    _message_controller.value = TextEditingValue(
                      text: fixed_text,
                      selection: TextSelection.collapsed(offset: str.length),
                    );

                    old_value = fixed_text;
                  },
                  onSubmitted: (str) {
                    // TODO: submit to chat
                    _message_controller.clear();
                    old_value = '';
                  },
                  decoration: InputDecoration(
                    hintText: 'Type message',
                    border: InputBorder.none,
                    contentPadding:
                        // TODO: fix alignment
                        EdgeInsets.only(left: 10, top: 12, bottom: 5),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const ChatBubble({Key key, this.text, this.isUser = true}) : super(key: key);

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