import 'package:flutter/material.dart';
import 'turnBox.dart';
import 'gradientButton.dart';

class ComponentsApi extends StatelessWidget {
  const ComponentsApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List _pageList = [
      {'title': 'gradientButtonApi', 'route': const GradientButtonApi()}, //
      {'title': 'turnBoxApi', 'route': const TurnBoxApi()},
    ];

    Widget _getPages(BuildContext context, int index) {
      return ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return _pageList[index]["route"];
            }));
          },
          child: Text(_pageList[index]["title"]));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('ComponentsApi')),
      body: ListView.builder(
        itemBuilder: _getPages,
        itemCount: _pageList.length,
      ),
    );
  }
}
