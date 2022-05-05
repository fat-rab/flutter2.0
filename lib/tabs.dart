import 'package:flutter/material.dart';
import 'package:myapp/pages/tabPages/home.dart';
import 'package:myapp/pages/tabPages/mine.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List _pageList = [const Home(), const Mine()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("HomePage"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          //shifting模式，此时需要配置selectedItemColor和unselectedItemColor
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            // 如果使用自定义图标需要使用icon和activeIcon设置选中和未选中的图标
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "设置")
          ],
        ),
        body: _pageList[_currentIndex]
        // Column(
        //   children: <Widget>[
        //     const Text("图片"),
        //     Image.asset('images/hun2.jpg'),
        //     const DecoratedBox(
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage('images/hun2.jpg'),
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //       child: SizedBox(
        //         width: 200,
        //         height: 200,
        //       ),
        //     )
        //   ],
        // ),
        );
  }
}
