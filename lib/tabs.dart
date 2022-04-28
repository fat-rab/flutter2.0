import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Column(
        children: <Widget>[
          const Text("图片"),
          Image.asset('images/hun2.jpg'),
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/hun2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox(
              width: 200,
              height: 200,
            ),
          )
        ],
      ),
    );
  }
}
