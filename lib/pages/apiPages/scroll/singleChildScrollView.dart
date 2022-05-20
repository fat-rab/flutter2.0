import 'package:flutter/material.dart';

//SingleChildScrollView 只应该在期望内容不会超过屏幕太多的情况下使用
// 因为SingleChildScrollView不支持Sliver的延迟加载模型，如果超过屏幕的内容很多，性能会很差
class SingleChildScrollViewWidget extends StatelessWidget {
  const SingleChildScrollViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //显示滚动条
    return Scaffold(
      appBar: AppBar(title: const Text("singleChildScroll")),
      body: Scrollbar(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: str
                .split("")
                .map((item) => Text(
                      item,
                      // 字体是原来的两倍
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      )),
    );
  }
}
