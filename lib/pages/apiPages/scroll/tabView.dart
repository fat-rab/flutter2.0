import 'package:flutter/material.dart';

class TabViewApi extends StatefulWidget {
  const TabViewApi({Key? key}) : super(key: key);

  @override
  _TabViewApiState createState() => _TabViewApiState();
}

// 混入SingleTickerProviderStateMixin提供动画效果
// class _TabViewApiState extends State<TabViewApi>
//     with SingleTickerProviderStateMixin {
//   final List _tabs = ["新闻", "历史", "图片"];
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: _tabs.length, vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   // TabBarView 通常配合AppBar中的TabBar使用，将他们的控制器设置为同一个控制器，即可同步控制
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("TabViewApi"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: _tabs.map((e) => Tab(text: e)).toList(),
//         ),
//       ),
//       //TabBarView内部封装了pageView,可以使用AutomaticKeepAliveClientMixin或者封装好的KeepAliveWrapper
//       // 如果不指定_tabController，那么TabBarView会在组件树上查找最近的一个DefaultTabController。
//       body: TabBarView(
//         controller: _tabController,
//         children: _tabs
//             .map((e) => Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     e,
//                     style: const TextStyle(fontSize: 22.0),
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }

// 但是像上面的方法使用TabBarView 比较麻烦，需要混入SingleTickerProviderStateMixin，有需要dispose释放资源，还需要手动
//设置控制器。所以可以创建一个DefaultTabController作为他们共同的父组件
// 使用DefaultTabController直接使用stateless widget就可以了，这边为了方便直接复制的上面的代码
class _TabViewApiState extends State<TabViewApi> {
  final List _tabs = ["新闻", "历史", "图片"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("TabViewApi"),
            bottom: TabBar(
              tabs: _tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
          body: TabBarView(
            children: _tabs
                .map((e) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 22.0),
                      ),
                    ))
                .toList(),
          ),
        ));
  }
}
