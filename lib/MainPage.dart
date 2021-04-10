import 'package:flutter/material.dart';
import 'package:protege/StudentChatPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isStudent = true;

  List<Widget> studentAssignmentsUnfinished = [
    StudentAssignmentPreview(),
  ];
  List<Widget> teacherAssignmentsUnfinished = [
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
  ];
  List<Widget> studentAssignmentsFinished = [
    StudentAssignmentPreview(),
    StudentAssignmentPreview(),
  ];
  List<Widget> teacherAssignmentsFinished = [
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
    TeacherAssignmentPreview(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Protégé'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    isStudent = true;
                  });
                },
                child: Text('Student',
                    style: TextStyle(color: Colors.white, fontSize: 18))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    isStudent = false;
                  });
                },
                child: Text('Teacher',
                    style: TextStyle(color: Colors.white, fontSize: 18))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
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
                  Expanded(
                    child: ListView(
                      children: [
                        ClassSelector(),
                        ClassSelector(),
                        ClassSelector(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'Unfinished Assignments',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        children: isStudent
                            ? studentAssignmentsUnfinished
                            : teacherAssignmentsUnfinished,
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Finished Assignments',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        children: isStudent
                            ? studentAssignmentsFinished
                            : teacherAssignmentsFinished,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TeacherAssignmentPreview extends StatelessWidget {
  const TeacherAssignmentPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          margin: const EdgeInsets.only(bottom: 8.0, right: 8.0),
          width: 300,
          height: 200,
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
              Spacer(),
              Divider(),
              Row(children: [Text('20/30'), Icon(Icons.person)]),
            ],
          )),
    );
  }
}

class StudentAssignmentPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => StudentChatPage())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        margin: const EdgeInsets.only(bottom: 8.0, right: 8.0),
        width: 300,
        height: 200,
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