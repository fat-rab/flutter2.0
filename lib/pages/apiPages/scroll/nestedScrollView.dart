import 'package:flutter/material.dart';

// NestedScrollView可以让两个
class NestedScrollViewApi extends StatelessWidget {
  const NestedScrollViewApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        // headerSliverBuilder 为外部滚动组件，只能接受sliver
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // 返回一个 Sliver 数组给外部可滚动组件。
          return <Widget>[
            //SliverAppBar是AppBar的Sliver版本
            SliverAppBar(
              title: const Text('嵌套ListView'),
              pinned: true, // 固定在顶部
              forceElevated: innerBoxIsScrolled, //导航栏下面是否一直显示阴影
            ),
            buildSliverList(5), //构建一个 sliverList
          ];
        },
        // body为内部可滚动组件，可以接受任意滚动组件包括sliver
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(),
          //设置为android效果，避免滑动到最上或者最下方时候出现弹性变形
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item $index')),
            );
          },
        ),
      ),
    );
  }
}

// 构建固定高度的SliverList，count为列表项属相
Widget buildSliverList([int count = 5]) {
  // SliverFixedExtentList对应指定itemExtend的ListView
  return SliverFixedExtentList(
    itemExtent: 50,
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return ListTile(title: Text('$index'));
      },
      childCount: count,
    ),
  );
}
