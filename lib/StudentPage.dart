import 'package:flutter/material.dart';
import 'package:protege/StudentChatPage.dart';

class StudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Protégé'),
      ),
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
                    'Your classes',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ClassSelector(),
                  ClassSelector(),
                  ClassSelector(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unfinished Assignments',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  AssignmentPreview(),
                  Text(
                    'Finished Assignments',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AssignmentPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StudentChatPage())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assignment 3: Induction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'due tomorrow',
              style: TextStyle(fontSize: 18, color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}

class ClassSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.red),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.edit),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(300),
            ),
          ),
          SizedBox(width: 16.0),
          Flexible(
            child: Text(
              "Mrs. Potter's 7th grade math class",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
