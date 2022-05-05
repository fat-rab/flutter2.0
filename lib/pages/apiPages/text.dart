import 'package:flutter/material.dart';

class TextApi extends StatelessWidget {
  const TextApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextApi')),
      body: const TextContainer()
    );
  }
}

//中间文字组件
class TextContainer extends StatelessWidget {
  const TextContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
      children: [
        Text(
          "hello,world" * 6,
          textAlign: TextAlign.center,
        ),
        Text("Hello world!" * 10, maxLines: 1, overflow: TextOverflow.ellipsis),
        const Text(
          "hello,world",
          textScaleFactor: 2, // 文本相对于当前字体大小的缩放因子，是调整字体大小的快捷方式
        ),
        Text(
          "hello,world",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              height: 1.2,
              //具体的行高等于fontSize*height
              background: Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
        const Text.rich(TextSpan(children: [
          //Text.rich 富文本标签
          TextSpan(text: "git:"),
          TextSpan(
              text: "https://github.com/fat-rab",
              style: TextStyle(color: Colors.blue))
        ])),
        DefaultTextStyle( //设置默认文本样式，子节点中的所有文本会默认使用这个样式
            style: const TextStyle(
              color: Colors.red,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("line1"),
                Text("line2"),
                Text(
                  "line3",
                  style: TextStyle(inherit: false, color: Colors.grey), //inherit: false 不使用默认样式
                )
              ],
            ))
      ],
    );
  }
}
