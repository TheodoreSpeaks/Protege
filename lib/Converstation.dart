import 'dart:async';
import 'package:http/http.dart' as http;
import 'OpenAI.dart';
import 'key.dart';

/*

curl https://api.openai.com/v1/engines/davinci/completions \
-H "Content-Type: application/json" \
-H "Authorization: Bearer YOUR_API_KEY" \
-d '{"prompt": "This is a test", "max_tokens": 5}'

*/

// Future<String> openAIComplete(prompt) async {
//   final response = await http.get(Uri.https(authority, unencodedPath));
// }

class Conversation {
  late List<String> convo;
  late Function stateCallback;
  static late OpenAI openAI;
  static String setup =
      "This following is a conversation between an AI student and a Human.  The AI is a studend learning from the Human.  The AI is curious, enthusiastic, polite, and smart\n";

  List<String> getConvo() {
    return convo;
  }

  Future<String> fakeAPI(currentPrompt) => Future.delayed(
        Duration(seconds: 2),
        () => 'completed: ' + currentPrompt,
      );

  Future<String> realAPI(prompt) async {
    return openAI.complete(prompt, 200);
  }

  static void initAI() {
    openAI = new OpenAI(apiKey: OpenAIConfig.key);
  }

  Conversation(this.convo, this.stateCallback);

  String getFullPrompt() {
    var prompt = "";
    for (var i = 0; i < this.convo.length; ++i) {
      var prefix = (i % 2 == 0) ? "" : "Human: ";
      prompt += prefix + this.convo[i] + "\n";
    }
    return setup + prompt;
  }

  Future<String> getCompletion() async {
    print("Full prompt: \n");
    print(getFullPrompt());
    var completion = await this.realAPI(this.getFullPrompt());
    print("Summary: " + await getSummary());
    return completion; // + "\n\nSUMMARY:\n" + await gtetSummary();
  }

  Future<String> getSummary() async {
    var prefix =
        "My second grader asked me what this passage means:\n \"\"\"\"\n";

    var postfix =
        "\n \"\"\"\"\n I rephrased it for him, in plain language a second grader can understand:\n";
    var summary = await this.realAPI(prefix + this.getFullPrompt() + postfix);
    return summary;
  }

  void updateConversation(String studentInput) async {
    this.convo.add(studentInput);
    stateCallback(this.convo);
    String completion = await this.getCompletion();
    print("Completion:\n");
    print(completion);
    this.convo.add(completion);
    stateCallback(this.convo);
  }
}
