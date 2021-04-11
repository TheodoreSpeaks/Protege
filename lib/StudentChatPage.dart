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
    print("submiting\n===========");
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/add_convo?convo=' + convo.getFullPrompt()));
    print("submitted\n===========");
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
      if (texts[i].length > 3 && texts[i].substring(0, 3) == "AI:")
        final_text += texts[i].substring(4) + "\n";
      else if (texts[i].length > 6 && texts[i].substring(0, 6) == "Human:")
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
                            'The Race for Space: \nA Look into the Cold War',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text('due Wednesday, April 4, 2021',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic)),
                              Spacer(),
                              Text('10 points', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                              "This week we wil be discussing the Cold War.  Here are some possible talking points:\n" +
                                  "\n1. Do you believe the United States should have followed a policy of containment during the ColdWar?" +
                                  "\n\n2. During the Second Red Scare, the U. S. government created policies and programs to stop the spread of communism at home.  " +
                                  "Were these programs justified and necessary?  Give specific examples in your answer." +
                                  "\n\n3. Were President Kennedy’s actions in foreign affairs (flexible response) good for the United States? Explain. " +
                                  "\n\n4) With reference to one country, assess the social impact of the Cold War. " +
                                  "\n\n5) To what extent did events in Eastern European countries contribute to the end of the Cold War?" +
                                  "\n\n6) Evaluate the impact of the Cold War on the culture of two countries, each chosen from a different region." +
                                  "\n\n7) Assess the part played by differing ideologies in the origin of the Cold War." +
                                  "\n\n8) Examine the conflicting aims and policies of rival powers which caused the Cold War." +
                                  "\n\n9)Review the Cold War era and the threats to American families. Include what you would do to protect your family in case of an attack. Include the following parts:" +
                                  "\n\n10) What were the consequences of the arms raceand space race in the USA and USSR?",
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
                                onTap: () {
                                  submitConvo();
                                },
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
