import 'package:flutter/material.dart';

class AnimatedSwitcherApi extends StatelessWidget {
  const AnimatedSwitcherApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedSwitcherApi')),
      body: const AnimatedSwitcherCounter(),
    );
  }
}

// const AnimatedSwitcher({
// Key? key,
// this.child,
// required this.duration, // 新child显示动画时长
// this.reverseDuration,// 旧child隐藏的动画时长
// this.switchInCurve = Curves.linear, // 新child显示的动画曲线
// this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
// this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
// this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
// })

class AnimatedSwitcherCounter extends StatefulWidget {
  const AnimatedSwitcherCounter({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitcherCounter> createState() =>
      _AnimatedSwitcherCounterState();
}

class _AnimatedSwitcherCounterState extends State<AnimatedSwitcherCounter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            //新child动画显示时长
            duration: const Duration(milliseconds: 500),
            //动画构建器，默认是FadeTransition
            transitionBuilder: (Widget child, Animation<double> animation) {
              // 缩放动画效果
              // return ScaleTransition(
              //   scale: animation,
              //   child: child,
              // );
              // 执行平移动画
              Animation<Offset> _animation = Tween<Offset>(
                      begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation);
              return MySlideTransition(
                child: child,
                position: _animation,
              );
            },
            child: Text(
              '$_count',
              // //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              child: const Text('add'))
        ],
      ),
    );
  }
}

// 自定义动画效果，旧child从左侧滑出，新child从右侧滑入

class MySlideTransition extends AnimatedWidget {
  const MySlideTransition(
      {Key? key,
      required Animation<Offset> position,
      this.transformHitTests = true,
      required this.child})
      : super(key: key, listenable: position);

  final bool transformHitTests;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    //FractionalTranslation 根据Offset平移控件，比如设置Offset的dx为0.25，那么在水平方向上平移控件1/4的宽度。
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
