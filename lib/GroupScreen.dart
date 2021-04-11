import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'GradingScreen.dart';
import 'SummarizationCard.dart';
import 'constants.dart';

class GroupScreen extends StatefulWidget {
  static const jsonData = [
    {
      'group_name': 'Group 1',
      'group_entries': [
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
      ]
    },
    {
      'group_name': 'Group 2',
      'group_entries': [
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
      ]
    },
    {
      'group_name': 'Group 3',
      'group_entries': [
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
        {
          'name': 'Chuck Miller',
          'summary':
              'Induction is blah blah blah blah blah lorem ipsum you know the drill by now'
        },
      ]
    },
  ];

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<dynamic> jsonData = [];
  void getJSON() async {
    final response = await http.get(Uri.http('127.0.0.1:5000', 'get_groups'));
    if (response.statusCode == 200) {
      //jsonData = jsonDecode(response.body);
      setState(() {
        jsonData = jsonDecode(response.body)['groups'];
        //   print("json $jsonData[0]");
      });
    } else {
      throw Exception("Failed to load groups");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJSON();
  }

  @override
  Widget build(BuildContext context) {
    //print("json lentgh ${jsonData.length}");
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GradingScreen(
                      json: this.jsonData,
                    ))),
            child: Container(
              width: 180,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.orange],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.assignment, color: Colors.white),
                    Text('Assign Grades',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            )),
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
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'The Race for Space: A Look into the Cold War Groups',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: this
                                .jsonData
                                .map((e) => GroupView(json: e))
                                .toList()),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class GroupView extends StatelessWidget {
  final dynamic json;
  const GroupView({
    Key? key,
    required this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        decoration: BoxDecoration(
            // color: Colors.grey[300],
            // border: Border.all(
            //   color: white,
            // ),
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(right: 16.0),
        child: Scrollbar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(json['group_name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, color: white)),
              SizedBox(height: 8.0),
              Expanded(
                  child: ListView.builder(
                itemCount: json['group_entries'].length,
                itemBuilder: (context, index) {
                  return SummarizationCard(
                    json: json['group_entries'][index],
                    showArrows: true,
                  );
                },
              )),
            ],
          ),
        ));
  }
}
