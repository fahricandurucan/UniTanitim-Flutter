import 'package:flutter/material.dart';

class MyContainerList extends StatefulWidget {
  @override
  _MyContainerListState createState() => _MyContainerListState();
}

class _MyContainerListState extends State<MyContainerList> {
  final List<String> _listItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 8',
    'Item 9',
    'Item 10'
  ];

  int _currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _currentIndex = isExpanded ? -1 : index;
            });
          },
          children:
          [
            for(int i=0;i<_listItems.length;i++)
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(_listItems[i]),
                  );
                },
                body: Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Expanded text for ${_listItems[i]}'),
                  ),
                ),
                isExpanded: i == _currentIndex,
              ),
          ]
        ),
      ),
    );
  }
}
