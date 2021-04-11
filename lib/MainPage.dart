import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protege/StudentChatPage.dart';
import 'package:protege/constants.dart';

import 'GroupScreen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isStudent = true;

  List<List<Widget>> studentAssignmentsUnfinished = [
    [
      StudentAssignmentPreview(
        assignmentName: 'The Race for Space: A Look into the Cold War',
      )
    ],
    [],
    [
      StudentAssignmentPreview(
        assignmentName: 'The Cool Jazz Era',
      )
    ],
  ];
  List<Widget> teacherAssignmentsUnfinished = [
    TeacherAssignmentPreview(
      assignmentName: 'The Race for Space: A Look into the Cold War',
    ),
  ];
  List<List<Widget>> studentAssignmentsFinished = [
    [
      StudentAssignmentPreview(
          assignmentName: 'World War II: The Pacific Theatre'),
      StudentAssignmentPreview(assignmentName: 'Analyzing Europe pre-WWI'),
      StudentAssignmentPreview(
          assignmentName: 'A House Divided: The Civil War'),
      StudentAssignmentPreview(
          assignmentName:
              'Manifest Destiny: Glorious Undertaking or Ruthless Colonialism?'),
      StudentAssignmentPreview(
          assignmentName:
              'To Form a More Perfect Union: The Creation of the Constitution'),
    ],
    [],
    [
      StudentAssignmentPreview(
          assignmentName: 'The life and death of John Coltrane'),
      StudentAssignmentPreview(assignmentName: 'The Swing Era'),
    ],
  ];
  List<Widget> teacherAssignmentsFinished = [
    TeacherAssignmentPreview(
        assignmentName: 'World War II: The Pacific Theatre'),
    TeacherAssignmentPreview(assignmentName: 'Analyzing Europe pre-WWI'),
    TeacherAssignmentPreview(assignmentName: 'A House Divided: The Civil War'),
    TeacherAssignmentPreview(
        assignmentName:
            'Manifest Destiny: Glorious Undertaking or Ruthless Colonialism?'),
    TeacherAssignmentPreview(
        assignmentName:
            'To Form a More Perfect Union: The Creation of the Constitution'),
  ];

  List<String> studentClasses = [
    "Mr. Wilson's 8th Grade History Class",
    "Mr. Runkle's 8th Grade English Class",
    "Mr. Mattsey's 8th Grade Jazz Class",
  ];

  List<String> teacherClasses = [
    "Mr. Wilson's 8th Grade History Class",
    "Mr. Wilson's Health Class",
  ];

  List<IconData> studentClassIcons = [
    Icons.public,
    Icons.book,
    Icons.music_note
  ];
  List<IconData> teacherClassIcons = [Icons.public, Icons.local_hospital];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/history.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(color: Colors.black54),
          Container(
            child: Column(
              children: [
                AppBar(
                  title: Text('Protégé',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            fontSize: 36,
                            // fontWeight: FontWeight.bold,
                            color: white),
                      )),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              isStudent = true;
                              _selectedIndex = 0;
                            });
                          },
                          child: Text('Student',
                              style: TextStyle(color: white, fontSize: 18))),
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
                              style: TextStyle(color: white, fontSize: 18))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.0),
                              Text(
                                'Your classes',
                                style: TextStyle(fontSize: 32, color: white),
                              ),
                              // SizedBox(height: 16),
                              Expanded(
                                  child: ListView.builder(
                                itemCount: isStudent
                                    ? studentClasses.length
                                    : teacherClasses.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => setState(() {
                                      _selectedIndex = index;
                                    }),
                                    child: ClassSelector(
                                      name: isStudent
                                          ? studentClasses[index]
                                          : teacherClasses[index],
                                      selected: index == _selectedIndex,
                                      icon: isStudent
                                          ? studentClassIcons[index]
                                          : teacherClassIcons[index],
                                      color: ColorUtil.getColor(index),
                                    ),
                                  );
                                },
                              )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16, bottom: 16.0),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    isStudent
                                        ? 'Unfinished Assignments'
                                        : 'Ungraded Assignments',
                                    style:
                                        TextStyle(fontSize: 32, color: white),
                                  ),
                                  SizedBox(height: 8),
                                  Wrap(
                                    children: isStudent
                                        ? studentAssignmentsUnfinished[
                                            _selectedIndex]
                                        : teacherAssignmentsUnfinished,
                                  ),
                                  SizedBox(height: 32),
                                  Text(
                                    isStudent
                                        ? 'Finished Assignments'
                                        : 'Graded Assignments',
                                    style:
                                        TextStyle(fontSize: 32, color: white),
                                  ),
                                  SizedBox(height: 8),
                                  Wrap(
                                    children: isStudent
                                        ? studentAssignmentsFinished[
                                            _selectedIndex]
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherAssignmentPreview extends StatelessWidget {
  final String assignmentName;
  final String completion;
  final String dueDate;
  final String lateCompletion;

  const TeacherAssignmentPreview({
    Key? key,
    this.assignmentName: 'Assignment 3: Induction',
    this.completion: '20/30',
    this.dueDate: 'Monday, April 12',
    this.lateCompletion: '5/30',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => GroupScreen())),
      child: Container(
          decoration: BoxDecoration(
            color: white,
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
                assignmentName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Divider(),
              Row(children: [Text(completion), Icon(Icons.person)]),
            ],
          )),
    );
  }
}

class StudentAssignmentPreview extends StatelessWidget {
  final String assignmentName;
  final String dueDate;

  const StudentAssignmentPreview(
      {Key? key,
      this.assignmentName: 'Assignment',
      this.dueDate: 'April 11, 2021'})
      : super(key: key);

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
          color: white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignmentName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Divider(),
            Text(
              dueDate,
              style: TextStyle(fontSize: 18, color: black),
            )
          ],
        ),
      ),
    );
  }
}

class ClassSelector extends StatelessWidget {
  final String name;
  final bool selected;
  final Color color;
  final IconData icon;

  const ClassSelector(
      {Key? key,
      required this.name,
      this.selected: false,
      required this.icon,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 8.0, right: 16.0, top: 8.0, bottom: 8.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: selected ? white : Colors.transparent,
              width: selected ? 1 : 0),
          color: Colors.transparent),
      width: double.infinity,
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            child: Icon(icon, size: 36),
            backgroundColor: color,
            foregroundColor: white,
          ),
          SizedBox(width: 16.0),
          Flexible(
            child: Text(
              name,
              style: TextStyle(fontSize: 18, color: white),
            ),
          ),
        ],
      ),
    );
  }
}
