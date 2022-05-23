import 'package:flutter/material.dart';

class AnimatedListApi extends StatefulWidget {
  const AnimatedListApi({Key? key}) : super(key: key);

  @override
  _AnimatedListApiState createState() => _AnimatedListApiState();
}

class _AnimatedListApiState extends State<AnimatedListApi> {
  final List<String> _data = [];
  int _counter = 5;
  GlobalKey<AnimatedListState> globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < _counter; i++) {
      _data.add("${i + 1}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AnimatedListApi")),
      body: Stack(
        children: [
          AnimatedList(
              key: globalKey,
              initialItemCount: _data.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: buildItem(context, index),
                );
              }),
          addButton()
        ],
      ),
    );
  }

  // 添加按钮
  Widget addButton() {
    return Positioned(
      child: ElevatedButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // 想要AnimatedList插入和删除 调用setState是没有效果的，必须调用AnimatedListState指定的方法
            // AnimatedListState.insertItem AnimatedListState.removeItem
            _data.add("${++_counter}");
            // 方法一，但是这里获取不到AnimatedList的context
            // AnimatedList.of(context).insertItem(_data.length - 1);
            // 方法二
            globalKey.currentState!.insertItem(_data.length - 1);
          }),
      left: 0,
      right: 0,
      bottom: 30,
    );
  }

  // 构建列表项
  Widget buildItem(context, index) {
    String char = _data[index];
    return ListTile(
      //使用char作为key
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          onDelete(context, index);
        },
      ),
    );
  }

  onDelete(context, index) {
    globalKey.currentState!.removeItem(index, (context, animation) {
      var item = buildItem(context, index);
      _data.removeAt(index);
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            //让透明度变化的更快一些
            curve: const Interval(0.5, 1.0),
          ),
          // 不断缩小列表项的高度
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: item,
          ));
    }, duration: const Duration(milliseconds: 200));
  }
}
