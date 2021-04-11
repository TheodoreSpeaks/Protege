import 'package:flutter/material.dart';

import 'ChatBubble.dart';

class SummarizationCard extends StatelessWidget {
  static const List<String> messages = [
    "AI: Can you teach me how todo an inductive proof?",
    "Human: Yes, first, there are 3 main steps to induction",
    "AI: What are the 3 steps to induction?",
    "Human: There is the Base Case, Inductive Step, Inductive Hypothesis",
    "AI: What is the Base Case?"
  ];

  const SummarizationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Column(children: [
                        AppBar(
                            title: Text("Chuck Millers conversation"),
                            leading: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(),
                            )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) => ChatBubble(
                              text: messages[index % messages.length],
                              isUser: index % 2 == 1,
                            ),
                            // TODO: remove, only for testing scrolling
                            itemCount: messages.length * 2,
                          ),
                        )),
                      ])),
                ),
              );
            });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            Text(
                'Induction is blah blah blah blah blah lorem ipsum you know the drill by now',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 8),
                Text('Chuck Miller'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
