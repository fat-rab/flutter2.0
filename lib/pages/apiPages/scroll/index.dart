import 'package:flutter/material.dart';
import 'animatedList.dart';
import 'controller.dart';
import 'gridView.dart';
import 'infiniteListView.dart';
import 'notification.dart';
import 'singleChildScrollView.dart';
import 'listView.dart';

class ScrollApi extends StatefulWidget {
  const ScrollApi({Key? key}) : super(key: key);

  @override
  _ScrollApiState createState() => _ScrollApiState();
}

class _ScrollApiState extends State<ScrollApi> {
  final List _pageList = [
    {
      "title": "SingleChildScrollView",
      "route": const SingleChildScrollViewWidget()
    },
    {"title": "ListView", "route": const ListViewWidget()},
    {"title": "InfiniteListView", "route": const InfiniteListView()},
    {"title": "ControllerApi", "route": const ControllerApi()},
    {
      "title": "NotificationListenerApi",
      "route": const NotificationListenerApi()
    },
    {"title": "AnimatedListApi", "route": const AnimatedListApi()},
    {"title": "GridViewApi", "route": const GridViewApi()},
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return _pageList[index]["route"];
        }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("scroll")),
      body: ListView.builder(
        itemBuilder: _getPages,
        itemCount: _pageList.length,
      ),
    );
  }
}
