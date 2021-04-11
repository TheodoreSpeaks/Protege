import 'package:flutter/material.dart';

import 'ChatBubble.dart';
import 'constants.dart';

class SummarizationCard extends StatelessWidget {
  // static const List<String> messages = [
  //   "AI: Can you teach me how todo an inductive proof?",
  //   "Human: Yes, first, there are 3 main steps to induction",
  //   "AI: What are the 3 steps to induction?",
  //   "Human: There is the Base Case, Inductive Step, Inductive Hypothesis",
  //   "AI: What is the Base Case?"
  // ];

  final dynamic json;
  static const dynamic defaultJson = {
    'name': 'Chuck Miller',
    'summary':
        'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
  };
  final bool showArrows;

  const SummarizationCard(
      {Key? key, this.json: defaultJson, this.showArrows: false})
      : super(key: key);

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
    List<String> messages = json['convo'].split("\n");
    messages.forEach((element) {
      element.trim();
    });
    while (messages.contains("")) {
      messages.remove("");
    }
    //print('json: $json');
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 600, maxWidth: 800),
                  child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Column(children: [
                        AppBar(
                            title: Text("${json['name']}'s conversation"),
                            backgroundColor: red,
                            leading: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(),
                            )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) => ChatBubble(
                              text: filter(messages[index % messages.length]),
                              isUser: index % 2 == 1,
                            ),
                            itemCount: messages.length,
                          ),
                        )),
                      ])),
                ),
              );
            });
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(json['summary'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorUtil.getRandomColor(),
                  child: Text(
                    json['name'][0],
                    style: TextStyle(fontSize: 24, color: white),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                  json['name'],
                  overflow: TextOverflow.ellipsis,
                )),
                showArrows
                    ? IconButton(
                        onPressed: () {}, icon: Icon(Icons.keyboard_arrow_left))
                    : Container(),
                showArrows
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_right))
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
