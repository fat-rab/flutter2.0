import 'package:flutter/material.dart';

class ColorApi extends StatelessWidget {
  const ColorApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ColorApi'),
      ),
      body: Column(
        children: <Widget>[
          // 颜色转换
          //背景为蓝色，则title自动为白色
          NavBar(color: ColorsUtil.hexToColor('#0A6FEB'), title: "标题"),
          //背景为白色，则title自动为黑色
          const NavBar(color: Color.fromRGBO(255, 255, 255, 1), title: "标题"),
        ],
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.color, required this.title})
      : super(key: key);
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints:
          const BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 3,
        )
      ]),
      child: Text(
        title,
        style: TextStyle(
          // 计算颜色亮度，返回0-1的值，值越大，颜色越浅
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class ColorsUtil {
  static Color hexToColor(String s) {
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (s.length != 7 || int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#999999';
    }
    return Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
