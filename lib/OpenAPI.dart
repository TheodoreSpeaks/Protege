import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:gpt_3_dart/gpt_3_dart.dart';

Future<String> getCompletion(currentPrompt) async {
  var completion = await fakeAPI();
  return completion;
}

Future<String> fakeAPI() => Future.delayed(
      Duration(seconds: 2),
      () => 'completion',
    );

// String getConversation() {
//     var convo = updateConversation();
//     return convo;
// }

class Conversation {
  late List<String> convo;
  // static OpenAI openAI;

  static void initAI() {
    //    openAI = new OpenAI(apiKey: "mykey");
  }
  Conversation() {
    convo = ["prompt"];
  }

  String getFullPrompt() {
    return convo.join("");
  }

  void updateConversation(String studentInput) async {
    convo.add(studentInput);
    String completion = await getCompletion(studentInput);
    //openAI.complete(prompt.last);
    convo.add(completion);
  }
}

class OpenAPITestScreen extends StatefulWidget {
  OpenAPITestScreen() : super();

  @override
  _OpenAPITestScreen createState() => _OpenAPITestScreen();
}

class _OpenAPITestScreen extends State<OpenAPITestScreen> {
  late Conversation convo;

  @override
  void initState() {
    super.initState();
    convo = new Conversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Text(convo.getFullPrompt())),
    );
  }
}
