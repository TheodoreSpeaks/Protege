import 'package:flutter/material.dart';
import 'ChatBubble.dart';
import 'Converstation.dart';

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
  late TextEditingController _messageController;
  late String _oldTextValue;
  late Conversation convo;

  late List<String> messages;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _oldTextValue = '';
    Conversation.initAI();
    convo = new Conversation([
      "AI: Can you teach me how todo an inductive proof?",
      "Human: Yes, first, there are 3 main steps to induction",
      "AI: What are the 3 steps to induction?",
      "Human: There is the Base Case, Inductive Step, Inductive Hypothesis",
      "AI: What is the Base Case?"
    ], this.messageCallback);
    messages = convo.getConvo();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void messageCallback(convo) {
    setState(() {
      messages = convo;
    });
  }

  String filter(text_input) {
    var texts = text_input.split("\n");
    var final_text = "";
    for (var i = 0; i < texts.length; ++i) {
      if (texts[i].length < 3) continue;
      if (texts[i].substring(0, 3) == "AI:")
        final_text += texts[i].substring(4) + "\n";
      else if (texts[i].substring(0, 6) == "Human:")
        final_text += texts[i].substring(7) + "\n";
      else
        final_text += texts[i] + "\n";
    }
    if (final_text.length < 1) return "";
    //print("no AI or human: " + text.substring(0, 7));
    return final_text.substring(0, final_text.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => ChatBubble(
            text: filter(messages[index]),
            isUser: index % 2 == 1,
          ),
          itemCount: messages.length,
        )),
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
                  controller: _messageController,
                  // onChanged: (str) {
                  //   // SO JANK DOESNT DELETE PROPERLY
                  //   final val = TextSelection.collapsed(
                  //       offset: _messageController.text.length);
                  //   _messageController.selection = val;

                  //   String fixed_text;
                  //   if (str.length > _oldTextValue.length) {
                  //     // Add new text
                  //     fixed_text =
                  //         (str.length != 0) ? str.substring(1) + str[0] : '';
                  //   } else {
                  //     fixed_text =
                  //         _oldTextValue.substring(0, _oldTextValue.length - 1);
                  //   }

                  //   _messageController.value = TextEditingValue(
                  //     text: fixed_text,
                  //     selection: TextSelection.collapsed(offset: str.length),
                  //   );

                  //   _oldTextValue = fixed_text;
                  // },
                  onSubmitted: (str) {
                    // TODO: submit to chat
                    _messageController.clear();
                    _oldTextValue = '';

                    convo.updateConversation(str);
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
