import 'package:flutter/material.dart';

class NotificationListenerApi extends StatefulWidget {
  const NotificationListenerApi({Key? key}) : super(key: key);

  @override
  _NotificationListenerApiState createState() =>
      _NotificationListenerApiState();
}

class _NotificationListenerApiState extends State<NotificationListenerApi> {
  String _progress = "0%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NotificationListenerApi')),
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            // pixels：当前滚动位置。
            // maxScrollExtent：最大可滚动长度。
            // extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
            // extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
            // extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
            // atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。
            double progress = scrollNotification.metrics.pixels /
                scrollNotification.metrics.maxScrollExtent;
            setState(() {
              // toInt() 将double转换为int,去除小数
              _progress = "${(progress * 100).toInt()}%";
            });
            return false;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                  itemCount: 50,
                  prototypeItem: const ListTile(title: Text("1")),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text("$index"));
                  }),
              CircleAvatar(
                child: Text(_progress),
                radius: 30.0,
                backgroundColor: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}
