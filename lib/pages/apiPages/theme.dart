import 'package:flutter/material.dart';

class ThemeApi extends StatefulWidget {
  const ThemeApi({Key? key}) : super(key: key);

  @override
  State<ThemeApi> createState() => _ThemeApiState();
}

class _ThemeApiState extends State<ThemeApi> {
  var _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
        data: ThemeData(
            ////用于导航栏、FloatingActionButton的背景色等
            primarySwatch: _themeColor,
            iconTheme: IconThemeData(color: _themeColor)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('theme'),
          ),
          body: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色跟随主题")
                  ]),
              //为第二行Icon自定义颜色（固定为黑色)
              // 可以通过局部主题覆盖全局主题
              Theme(
                data: ThemeData(iconTheme: const IconThemeData(color: Colors.black)),
                // data:themeData.copyWith(
                // iconTheme:
                // themeData.iconTheme.copyWith(color: Colors.black)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.airport_shuttle),
                      Text("  颜色固定黑色")
                    ]),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
            child: const Icon(Icons.palette),
          ),
        ));
  }
}
