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
          // 左上角按钮，如果Scaffold设置了drawer，自动出现按钮，也可以手动自定义
          leading: Builder(builder: (context) {
            return IconButton(
                icon: const Icon(Icons.dashboard, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                });
          }),
          //右上角按钮
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.menu));
            })
          ],
        ),
        //左侧drawer 如果AppBar不设置leading,左上角会自动出现按钮打开drawer
        drawer: const MyDrawer(),
        // 右侧菜单.如果AppBar不设置actions,那么右上角会自动出现menu按钮，点击打开endDrawer
        endDrawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
          // 右下角悬浮按钮
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        //设置浮动按钮位置
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // 配合floatingActionButton的底部导航
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          //阴影
          elevation: 8.0,
          //边距
          notchMargin: 5.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? Colors.blue : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              const SizedBox(), //中间位置空出
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: _currentIndex == 1 ? Colors.blue : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
        //底部导航
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   //shifting模式，此时需要配置selectedItemColor和unselectedItemColor
        //   type: BottomNavigationBarType.shifting,
        //   selectedItemColor: Theme.of(context).primaryColor,
        //   unselectedItemColor: Colors.black,
        //   onTap: (int index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        //   items: const <BottomNavigationBarItem>[
        //     // 如果使用自定义图标需要使用icon和activeIcon设置选中和未选中的图标
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
        //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "设置")
        //   ],
        // ),
        body: _pageList[_currentIndex]);
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // 可以移除drawer默认的一些留白
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/hun2.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  const Text(
                    "test",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add account'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
