import 'package:flutter/material.dart';
import 'SummarizationCard.dart';
import 'constants.dart';

class GradingScreen extends StatefulWidget {
  final List<dynamic> json;

  const GradingScreen({Key? key, required this.json}) : super(key: key);
  @override
  _GradingScreenState createState() => _GradingScreenState();
}

class _GradingScreenState extends State<GradingScreen> {
  late dynamic _dropDownValue;

  @override
  void initState() {
    super.initState();

    _dropDownValue = widget.json[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DropdownButton(
                      //   value: _dropDownValue,
                      //   onChanged: (dynamic val) {
                      //     setState(() {
                      //       _dropDownValue = val;
                      //     });
                      //   },
                      //   items: widget.json.map((e) {
                      //     return DropdownMenuItem(
                      //         value: e, child: Text(e['group_name']));
                      //   }).toList(),
                      // ),
                      Expanded(
                        child: RubricSelector(),
                      ),
                    ])),
            Expanded(
                flex: 5,
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Wrap(
                    //     children: _dropDownValue['group_entries'].map((json) {
                    //   print('$json');
                    //   return SummarizationCard(json: json);
                    // }).toList())
                  ],
                ))),
          ],
        ));
  }
}

class RubricSelector extends StatefulWidget {
  const RubricSelector({
    Key? key,
  }) : super(key: key);

  @override
  _RubricSelectorState createState() => _RubricSelectorState();
}

class _RubricSelectorState extends State<RubricSelector> {
  int selectedIndex = -1;

  List<dynamic> criteria = [
    {
      'number': '4',
      'color': green,
      'label':
          'Student exceeded expectations by using course materials to create a meaningful conversation.'
    },
    {
      'number': '3',
      'color': blue,
      'label':
          'Student covered most topics and somewhat used them to construct new ideas.'
    },
    {
      'number': '2',
      'color': yellow,
      'label': 'Student covered some topics but failed to synthesize new ideas.'
    },
    {
      'number': '1',
      'color': red,
      'label':
          'No attempt was made to direct the conversation to a meaningful prompt.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: criteria.length,
        itemBuilder: (context, index) {
          dynamic data = criteria[index];
          return InkWell(
            onTap: () => setState(() {
              if (selectedIndex == index) {
                selectedIndex = -1;
              } else {
                selectedIndex = index;
              }
            }),
            child: RubricCriteria(
                selected: selectedIndex == index,
                number: data['number'],
                color: data['color'],
                label: data['label']),
          );
        });
  }
}

class RubricCriteria extends StatelessWidget {
  final String number;
  final String label;
  final Color color;
  final bool selected;
  const RubricCriteria({
    Key? key,
    required this.number,
    required this.label,
    required this.color,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          CircleAvatar(
            maxRadius: 28,
            backgroundColor: selected ? color : Colors.grey,
            child: Text(number,
                style: TextStyle(fontSize: 28, color: Colors.white)),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label, style: TextStyle(fontSize: 20)),
            ),
          )
        ]));
  }
}
