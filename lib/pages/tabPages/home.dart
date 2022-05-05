import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _pageList = [
    {"title": "text", "routeName": "/textApi"},
    {"title": "button", "routeName": "/buttonApi"},
  ];

  Widget _getPages(context, index) {
    return ElevatedButton(
      style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all(const TextStyle(fontSize: 20)) //字体大小
          // foregroundColor: MaterialStateProperty.all(Colors.red) // 字体颜色
          ),
      child: Text(_pageList[index]["title"]),
      onPressed: () {
        Navigator.pushNamed(context, _pageList[index]["routeName"]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //ListView.builder 列表懒加载
    return ListView.builder(
      itemBuilder: _getPages,
      itemCount: _pageList.length,
    );
  }
}
