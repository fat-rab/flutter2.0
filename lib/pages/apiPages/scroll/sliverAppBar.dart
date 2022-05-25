import 'package:flutter/material.dart';

// const SliverAppBar({
// this.collapsedHeight, // 收缩起来的高度
// this.expandedHeight,// 展开时的高度
// this.pinned = false, // 是否固定
// this.floating = false, //是否漂浮
// this.snap = false, // 当漂浮时，此参数才有效
// bool forceElevated //导航栏下面是否一直显示阴影
// ...
// })

class SliverAppBarApi extends StatelessWidget {
  const SliverAppBarApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NestedTabBarView1();
  }
}

class NestedTabBarView1 extends StatelessWidget {
  const NestedTabBarView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabs = <String>['猜你喜欢', '今日特价', '发现更多'];
    // 构建 tabBar
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: const Text("NestedTabBarView"),
                    floating: true,
                    snap: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      tabs: _tabs.map((e) => Tab(text: e)).toList(),
                    ),
                  ),
                )
              ];
            },
            body: TabBarView(
              children: _tabs.map((e) {
                return Builder(builder: (BuildContext context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(e),
                    slivers: [
                      SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: buildSliverList(100),
                      )
                    ],
                  );
                });
              }).toList(),
            ),
          ),
        ));
  }
}

// 通过SliverOverlapAbsorber和SliverOverlapInjector配合解决sliverAppBar1的问题
// 为flutter提供的标准解决方案
Widget sliverAppBar2() {
  return Scaffold(
    body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // 将SliverAppBar 使用SliverOverlapAbsorber包裹起来，可以获得SliverBar返回时候，遮住可滚动组件的长度
          SliverOverlapAbsorber(
            // SliverOverlapAbsorber和SliverOverlapInjector的通信桥梁
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "images/hun2.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ];
      },
      body: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          slivers: <Widget>[
            // SliverOverlapInjector通过SliverOverlapAbsorber和自身设置的handle，将滚动组件推动SliverAppbar遮住的距离
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            buildSliverList(100)
          ],
        );
      }),
    ),
  );
}

// 当上滑的时候，sliverAppBar不会固定在最上方，会移动到屏幕之外
// 下拉的时候sliverAppBar会立刻出现在屏幕上，但是会遮住滚动组件
Widget sliverAppBar1() {
  return Scaffold(
    body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // 实现 snap 效果
          SliverAppBar(
            floating: true,
            snap: true,
            expandedHeight: 200,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "./imgs/sea.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          slivers: <Widget>[buildSliverList(100)],
        );
      }),
    ),
  );
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
