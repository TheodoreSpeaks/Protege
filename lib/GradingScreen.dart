import 'package:flutter/material.dart';
import 'SummarizationCard.dart';
import 'constants.dart';

class GradingScreen extends StatefulWidget {
  final List<dynamic> json;

  const GradingScreen({Key? key, required this.json}) : super(key: key);
  @override
  _GradingScreenState createState() => _GradingScreenState();
}

class _GradingScreenState extends State<GradingScreen>
    with SingleTickerProviderStateMixin {
  late dynamic _dropDownValue;
  late TabController _tabController;
  late List<Widget> _rubrics;
  late List<List<Widget>> _summaries;

  @override
  void initState() {
    super.initState();

    _dropDownValue = widget.json[0];
    _tabController = TabController(vsync: this, length: widget.json.length);
    _rubrics = widget.json.map<Widget>((_) => RubricSelector()).toList();
    _summaries = widget.json
        .map<List<Widget>>((group) => group['group_entries'].map<Widget>((e) {
              Widget toReturn = Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: SummarizationCard(json: e));
              return toReturn;
            }).toList())
        .toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                      TabBar(
                        controller: _tabController,
                        labelStyle: TextStyle(color: Colors.black87),
                        tabs: widget.json
                            .map<Widget>((e) => Tab(
                                child: Text(e['group_name'],
                                    style: TextStyle(color: Colors.black87))))
                            .toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: _rubrics,
                        ),
                      ),
                    ])),
            Expanded(
                flex: 5,
                child: Container(
                  child: TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: _summaries
                          .map((summaries) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [Wrap(children: summaries)])))
                          .toList()),
                )),
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

class _RubricSelectorState extends State<RubricSelector>
    with AutomaticKeepAliveClientMixin<RubricSelector> {
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
