import 'package:flutter/material.dart';

class CustomScrollViewApi extends StatefulWidget {
  const CustomScrollViewApi({Key? key}) : super(key: key);

  @override
  _CustomScrollViewApiState createState() => _CustomScrollViewApiState();
}

class _CustomScrollViewApiState extends State<CustomScrollViewApi> {
  @override
  Widget build(BuildContext context) {
    return PersistentHeaderRoute();
  }
}

Widget buildTwoSliverList() {
  // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
  // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
  // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
  var listView = SliverFixedExtentList(
    itemExtent: 56, //列表项高度固定
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) => ListTile(title: Text('$index')),
      childCount: 10,
    ),
  );
  return Scaffold(
    appBar: AppBar(title: const Text('CustomScrollView')),
    // CustomScrollView需要传入sliver类型的组件组成的数据
    body: CustomScrollView(
      slivers: [listView, listView],
    ),
  );
}

// 常用Sliver
Widget commonSliver() {
  return Material(
    child: CustomScrollView(
      slivers: <Widget>[
        // 对应AppBar，可以在CustomScrollView使用，包含一个导航栏.
        SliverAppBar(
          pinned: true, // 滑动到顶端时会固定住
          expandedHeight: 250.0,
          title: const Text("朋友圈"),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Demo'),
            background: Image.asset(
              "images/hun2.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 对应Padding
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            //Grid
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //Grid按两列显示
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建子widget
                return Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建列表项
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ),
  );
}

//SliverToBoxAdapter
// 有时候需要在CustomScrollView中添加一些自定义的组件，但是这些组件并不是Sliver类型的
// 可以使用SliverToBoxAdapter将RenderBox适配为SliverToBoxAdapter
Widget sliverToBoxAdapter() {
  var listView = SliverFixedExtentList(
    itemExtent: 56, //列表项高度固定
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) => ListTile(title: Text('$index')),
      childCount: 10,
    ),
  );
  var demo = SliverToBoxAdapter(
    child: SizedBox(
      height: 300,
      child: PageView(
        children: const [Text("1"), Text("2")],
      ),
    ),
  );
  return Scaffold(
    appBar: AppBar(title: const Text('sliverToBoxAdapter')),
    // CustomScrollView需要传入sliver类型的组件组成的数据
    body: CustomScrollView(
      // 此时代码可以正常运行，但是如果将PageView的滑动方向变成和CustomScrollView一致，则无法正常运行
      // 如果需要解决这个问题，需要使用NestedScrollView
      slivers: [demo, listView],
    ),
  );
}

//SliverPersistentHeader
//功能是滑动到CustomScrollView的顶部的时候，可以将组件固定在顶部。
typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

//SliverPersistentHeader中的delegate类型是SliverPersistentHeaderDelegate，是一个抽象类，需要自己实现
//https://book.flutterchina.club/chapter6/custom_scrollview.html#_6-10-2-flutter-%E4%B8%AD%E5%B8%B8%E7%94%A8%E7%9A%84-sliver
class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
      }
      return true;
    }());
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}

class PersistentHeaderRoute extends StatelessWidget {
  const PersistentHeaderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SliverPersistentHeader")),
      body: CustomScrollView(
        slivers: [
          buildSliverList(),
          SliverPersistentHeader(
            pinned: true,
            // SliverHeaderDelegate是SliverPersistentHeaderDelegate抽象类的实现
            delegate: SliverHeaderDelegate(
              //有最大和最小高度
              maxHeight: 80,
              minHeight: 50,
              child: buildHeader(1),
            ),
          ),
          buildSliverList(),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate.fixedHeight( //固定高度
              height: 50,
              child: buildHeader(2),
            ),
          ),
          buildSliverList(20),
        ],
      ),
    );
  }

  // 构建固定高度的SliverList，count为列表项属相
  // SliverFixedExtentList对应指定itemExtend的ListView
  Widget buildSliverList([int count = 5]) {
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

  // 构建 header
  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text("PersistentHeader $i"),
    );
  }
}