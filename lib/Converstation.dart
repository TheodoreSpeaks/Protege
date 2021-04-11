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
      "This following is a conversation between an AI student and a Human Teacher.  The AI is a student learning from the Human.  The AI is a B student, curious, enthusiastic, polite,  vague, confused, foolish,  and asks questions about what the Human Teacher says.  \n" +
          "AI: Hi, what are we learning about today?\n" +
          "Human: We will be learning about history.\n" +
          "AI: What time period will be learning about?\n" +
          "Human: We will learn about World War One.  Do you know when WWI started?\n" +
          "AI: My knowledge is it started in the 1900's, is that correct?\n" +
          "Human: Correct, it started in 1914.  What was the political environment in Europe like at the time?\n" +
          "AI: I recall that Germany was gaining power.\n" +
          "Human: Yes, what actually started the war?\n" +
          "AI: I read that to start the war, Germany declared war on France.\n" +
          "Human: That is partially correct.\n" +
          "AI: So, it was the German's fault?\n" +
          "Human: Not entirely, they had an alliance with Austria that pulled them into it.  Does that make sense?\n" +
          "AI: Yes, I understand.\n" +
          "Human: Okay, can you tell me what you have learned?\n" +
          "AI: I learned that Germany started the war, and I learned that it was not entirely their fault.\n";

  List<String> getConvo() {
    return convo;
  }

  Future<String> fakeAPI(currentPrompt) => Future.delayed(
        Duration(seconds: 2),
        () => 'completed: ' + currentPrompt,
      );

  Future<String> realAPI(prompt) async {
    print("THE AI COMPLETED: ${setup + prompt}");
    return openAI.complete(setup + prompt, 200);
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
    return prompt;
  }

  Future<String> getCompletion() async {
    //print("Full prompt: \n");
    //print(getFullPrompt());
    var completion = "";
    while (completion == "") {
      completion = await this.realAPI(this.getFullPrompt());
    }
    //print("Summary: " + await getSummary());
    return completion; // + "\n\nSUMMARY:\n" + await gtetSummary();
  }

  Future<String> getSummary() async {
    var prefix =
        "My second grader asked me what this passage means:\n \"\"\"\"\n";

    var postfix =
        "\n \"\"\"\"\n I rephrased it for him, in plain language a second grader can understand:\n\"\"\"\"";
    var summary = await this.realAPI(prefix + this.getFullPrompt() + postfix);
    return summary;
  }

  void updateConversation(String studentInput) async {
    this.convo.add(studentInput);
    stateCallback(this.convo);
    String completion = await this.getCompletion();
    //print("Completion:\n");
    // print(completion);
    this.convo.add(completion);
    stateCallback(this.convo);
  }
}
