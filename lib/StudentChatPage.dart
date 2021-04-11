import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ChatBubble.dart';
import 'Converstation.dart';
import 'constants.dart';

class StudentChatPage extends StatefulWidget {
  @override
  _StudentChatPageState createState() => _StudentChatPageState();
}

class _StudentChatPageState extends State<StudentChatPage> {
  late TextEditingController _messageController;
  late String _oldTextValue;
  late Conversation convo;

  late List<String> messages;
  void submitConvo() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/add_convo?convo=' + convo.getFullPrompt()));
    print("submitted");
  }

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _oldTextValue = '';
    Conversation.initAI();
    convo = new Conversation([
      "AI: Can you teach me about the Space Race today?",
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: white,
              child: Column(
                children: [
                  AppBar(elevation: 0, backgroundColor: red),
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assignment 3: Induction',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
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
                        ],
                      )),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('lib/assets/space.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  Container(color: Colors.black54),
                  Column(
                    children: [
                      AppBar(
                        elevation: 0,
                        leading: Container(),
                        backgroundColor: Colors.transparent,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {},
                                // => Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => GradingScreen(
                                //           json: this.jsonData,
                                //         ))),
                                child: Container(
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                          colors: [Colors.red, Colors.orange],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.login, color: Colors.white),
                                        Text('Submit',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_vert)),
                        ],
                      ),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: IconButton(
                                icon: Icon(Icons.mic, color: Colors.white),
                                onPressed: () {}),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: white,
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
                                      EdgeInsets.only(
                                          left: 10, top: 12, bottom: 5),
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
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
