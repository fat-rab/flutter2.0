import 'package:flutter/material.dart';

//ListView
// ListView 适用于widget数量已知并且数量较少的时候，否则应该使用ListView.builder()
// ListView.separated 比ListView.builder多出一个分割线构造器
class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget divider1 = const Divider(color: Colors.red);
    Widget divider2 = const Divider(color: Colors.blue);
    return Scaffold(
      appBar: AppBar(title: const Text("listView")),
      body: ListView.builder(
          itemCount: 50,
          //itemExtent: 20, // 垂直方向为子组件高度，水平方向为子组件宽度，指定高度可以获得更好的性能
          //如果不知道子组件具体高度，但是子组件高度都是相同的话，可以设置其中一个子组件为原型，这样滚动组件会在layout的时候计算
          //延主轴方向的长度，再根据itemCount计算就可以知道每个组件的长度，也可以获得跟好的性能，这个参数和itemExtent互斥
          prototypeItem: const ListTile(title: Text("1")),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          }),
    );

    // ListView.separated(
    //     itemCount: 50,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Text("$index");
    //     },
    //     // 分割线构造器
    //     separatorBuilder: (BuildContext context, int index) {
    //       return index % 2 == 0 ? divider1 : divider2;
    //     })
    // ListView.builder(
    //     itemCount: 50,
    //     itemExtent: 20, // 垂直方向为子组件高度，水平方向为子组件宽度，指定高度可以获得更好的新能
    //     itemBuilder: (BuildContext context, int index) {
    //       return Text("$index");
    //     })
    // ListView(
    //   shrinkWrap: true,
    //   padding: const EdgeInsets.all(20.0),
    //   children: const <Widget>[
    //     Text('I\'m dedicating every day to you'),
    //     Text('Domestic life was never quite my style'),
    //     Text('When you smile, you knock me out, I fall apart'),
    //     Text('And I thought I was so smart'),
    //   ],
    // );
  }
}
