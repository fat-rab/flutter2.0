import 'package:flutter/material.dart';

class MultiAnimationApi extends StatelessWidget {
  const MultiAnimationApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MultiAnimationApi')),
      body: const StaggerRoute(),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key? key, required this.controller}) : super(key: key) {
    //高度动画
    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
    padding = Tween<EdgeInsets>(
            begin: const EdgeInsets.only(left: 0),
            end: const EdgeInsets.only(left: 100))
        .animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1, curve: Curves.easeIn)));
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        width: 50.0,
        height: height.value,
        color: color.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}

class StaggerRoute extends StatefulWidget {
  const StaggerRoute({Key? key}) : super(key: key);

  @override
  State<StaggerRoute> createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    super.initState();
  }

  _playAnimation() async {
    try {
      // 正向运行
      await _controller.forward().orCancel;
      // 反向
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      print('cancel');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _playAnimation();
              },
              child: const Text('开始动画')),
          Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                )),
            child: StaggerAnimation(controller: _controller),
          )
        ],
      ),
    );
  }
}
