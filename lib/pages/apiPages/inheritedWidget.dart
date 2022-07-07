import 'package:flutter/material.dart';

class InheritedWidgetAPi extends StatefulWidget {
  const InheritedWidgetAPi({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetAPi> createState() => _InheritedWidgetAPiState();
}

class _InheritedWidgetAPiState extends State<InheritedWidgetAPi> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidgetAPi'),
      ),
      body: Center(
          child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.only(bottom: 20.0), child: TextWidget()),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    ++count;
                  });
                },
                child: const Text('add'))
          ],
        ),
      )),
    );
  }
}

class TextWidget extends StatefulWidget {
  const TextWidget({Key? key}) : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    // print(ShareDataWidget.of(context)?.data);
    // ! 感叹号为非空断言
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override
  void didChangeDependencies() {
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    super.didChangeDependencies();
  }
}

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);
  final int data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 该回调决定当data发生变化的时候，是否通知子树中依赖data的widget重新build
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}
