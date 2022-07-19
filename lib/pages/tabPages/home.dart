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
    {"title": "image", "routeName": "/imageApi"},
    {"title": "form", "routeName": "/formApi"},
    {"title": "progress", "routeName": "/progressApi"},
    {"title": "layout", "routeName": "/layoutApi"},
    {"title": "container", "routeName": "/containerApi"},
    {"title": "scroll", "routeName": "/scrollApi"},
    {"title": "willPopScope", "routeName": "/willPopScopeApi"},
    {"title": "inheritedWidget", "routeName": "/inheritedWidgetAPi"},
    {"title": "providerApi", "routeName": "/providerApi"},
    {"title": "colorApi", "routeName": "/colorApi"},
    {"title": "themeApi", "routeName": "/themeApi"},
    {"title": "valueListenableApi", "routeName": "/valueListenableApi"},
    {"title": "asyncBuilderApi", "routeName": "/asyncBuilderApi"},
    {"title": "dialogApi", "routeName": "/dialogApi"},
    {"title": "pointerEventApi", "routeName": "/pointerEventApi"},
    {"title": "gestureApi", "routeName": "/gestureApi"},
    {"title": "eventBusApi", "routeName": "/eventBusApi"},
    {"title": "customNotificationApi", "routeName": "/customNotificationApi"},
    {"title": "baseAnimationApi", "routeName": "/baseAnimationApi"},
    {"title": "heroAnimationApiA", "routeName": "/heroAnimationApiA"},
    {"title": "multiAnimationApi", "routeName": "/multiAnimationApi"},
    {"title": "animatedSwitcherApi", "routeName": "/animatedSwitcherApi"},
    {"title": "animatedWidgetsApi", "routeName": "/animatedWidgetsApi"},
    {"title": "componentsApi", "routeName": "/componentsApi"},
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
      // 路由传参
      // onPressed: () {
      //   Navigator.pushNamed(context, _pageList[index]["routeName"],
      //       arguments: ScreenArguments(18, title: "123"));
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    //ListView.builder 列表懒加载
    // ListView默认垂直排列，此时内部元素宽度失效，自动撑满，
    // 如果改为水平排列，则高度失效
    return Scrollbar(
        child: ListView.builder(
      itemBuilder: _getPages,
      itemCount: _pageList.length,
    ));
  }
}

// 定义路由传参的类型
class ScreenArguments {
  final String title;
  final int age;

  //使用{}包裹是命名参数
  ScreenArguments(this.age, {required this.title});
}
