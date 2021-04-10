import 'package:flutter/material.dart';
import 'dart:async';

Future<String> getCompletion(currentPrompt) async {
  var completion = await fakeAPI(currentPrompt);
  return completion;
}

Future<String> fakeAPI(currentPrompt) => Future.delayed(
      Duration(seconds: 2),
      () => 'completed: ' + currentPrompt,
    );

// String getConversation() {
//     var convo = updateConversation();
//     return convo;
// }

class Conversation {
  late List<String> convo;
  late Function stateCallback;
  // static OpenAI openAI;

  List<String> getConvo() {
    return convo;
  }

  static void initAI() {
    //    openAI = new OpenAI(apiKey: "mykey");
  }
  Conversation(this.convo, this.stateCallback);

  String getFullPrompt() {
    return convo.join("\n");
  }

  Future<String> getCompletion() async {
    var completion = await fakeAPI(this.getFullPrompt());
    return completion;
  }

  void updateConversation(String studentInput) async {
    convo.add(studentInput);
    stateCallback(convo);
    String completion = await this.getCompletion();
    //openAI.complete(prompt.last);
    convo.add(completion);
    stateCallback(convo);
  }
}
