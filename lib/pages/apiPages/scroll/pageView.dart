import 'package:flutter/material.dart';

class PageViewApi extends StatefulWidget {
  const PageViewApi({Key? key}) : super(key: key);

  @override
  _PageViewApiState createState() => _PageViewApiState();
}

class _PageViewApiState extends State<PageViewApi> {
  List<Widget> children = [];

  @override
  void initState() {
    for (var i = 0; i < 6; i++) {
      children.add(Page(
        text: "$i",
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("pageView")),
      body: PageView(
        // 滑动方向，默认水平方向滑动
        //scrollDirection: Axis.vertical,
        // 缓存，但是只能缓存当前页面的前面和后面一页
        //allowImplicitScrolling: true,
        children: children,
      ),
    );
  }
}

// Tab 页面
class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _PageState createState() => _PageState();
}

//使用AutomaticKeepAliveClientMixin 即可缓存自己想要缓存的所有页面
class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // 使用AutomaticKeepAliveClientMixin，必须调用，根据当前wantKeepAlive的值给AutomaticKeepAlive发送消息
    super.build(context); // 必须调用
    return Center(child: Text(widget.text, textScaleFactor: 5));
  }

  @override
  bool get wantKeepAlive => true; // 是否需要缓存，可以根据条件来判断
}

// 也可以使用下面KeepAliveWrapper代码传入需要缓存的widget进行缓存
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
