import 'package:flutter/material.dart';

class BaseAnimationApi extends StatelessWidget {
  const BaseAnimationApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BaseAnimationApi')),
      body: const AnimationApi1(),
    );
  }
}

class ScaleAnimationApi extends StatefulWidget {
  const ScaleAnimationApi({Key? key}) : super(key: key);

  @override
  State<ScaleAnimationApi> createState() => _ScaleAnimationApiState();
}

// 混入SingleTickerProviderStateMixin
// 如果有多个controller则需要混入TickerProviderStateMixin
class _ScaleAnimationApiState extends State<ScaleAnimationApi>
    with SingleTickerProviderStateMixin {
  // Animation<double> 是Animation的一个常用类
  // Animation对象可以在一段事件内一次生成一个区间(Tween)之间的值，出了double也可以生成color或者size等值
  // 可以通过Animation.value获取状态值
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, //接受TickerProvider类型的参数，驱动动画会防止屏幕外动画（用户锁屏等情况，动画不运行）
        duration: const Duration(seconds: 2));

    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 可以设置区间，默认0.0~1.0
    // 动画默认是匀速
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        //帧监听器，动画的每一帧都会触发
        setState(() {});
      })
      ..addStatusListener((status) {
        // 动画状态监听器动画开始，结束，正向或者反向的时候都会触发
        print(status);
        // dismissed	动画在起始点停止
        // forward	动画正在正向执行
        // reverse	动画正在反向执行
        // completed	动画在终点停止
      });
    // 动画启动
    // stop 停止
    // reverse 反向播放
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "images/hun2.jpg",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute1 extends StatefulWidget {
  const ScaleAnimationRoute1({Key? key}) : super(key: key);

  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 省去了通过addListener()和setState() 来更新UI
    // return AnimatedImage(
    //   animation: animation,
    // );
    // AnimatedBuilder
    // 省去了通过addListener()和setState() 来更新UI
    // 更好的性能，动画每一帧重构的范围变小
    // 可以用来复用动画效果（将animation和child作为参数传入即可），flutter就是用这种方法封装了很多动画效果
    return AnimatedBuilder(
        animation: animation,
        child: Image.asset("images/hun2.jpg"),
        builder: (BuildContext ctx, Widget? child) {
          return Center(
            child: SizedBox(
              width: animation.value,
              height: animation.value,
              child: child, // 参数传入的child,这边是Image
            ),
          );
        });
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({Key? key, required Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        "images/hun2.jpg",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

// 封装之后的用法
class AnimationApi1 extends StatefulWidget {
  const AnimationApi1({Key? key}) : super(key: key);

  @override
  State<AnimationApi1> createState() => _AnimationApi1State();
}

class _AnimationApi1State extends State<AnimationApi1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addStatusListener((status) {
        // 如果想让动画循环播放，改变controller的状态即可
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GrowTransition(
        animation: animation,
        child: Image.asset(
          "images/hun2.jpg",
        ),
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({Key? key, required this.child, required this.animation})
      : super(key: key);
  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext ctx, Widget? child) {
        return SizedBox(
          width: animation.value,
          height: animation.value,
          child: child,
        );
      },
      child: child,
    );
  }
}
