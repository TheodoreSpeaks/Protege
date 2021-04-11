import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: Text('Assign Grades'),
            icon: Icon(Icons.assignment)),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.pink],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight)),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assignment 3: Induction Groups',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Row(children: [
                  GroupView(),
                  GroupView(),
                  GroupView(),
                ]),
              )
            ],
          ),
        ));
  }
}

class GroupView extends StatelessWidget {
  const GroupView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Container(
          width: 350,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Group 1',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8.0),
              Expanded(
                child: ListView(
                  children: [
                    SummarizationCard(),
                    SummarizationCard(),
                    SummarizationCard(),
                    SummarizationCard(),
                    SummarizationCard(),
                    SummarizationCard(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class SummarizationCard extends StatelessWidget {
  const SummarizationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
