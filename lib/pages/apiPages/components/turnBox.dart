import 'package:flutter/material.dart';

class TurnBox extends StatefulWidget {
  const TurnBox(
      {Key? key, this.turns = .0, this.speed = 200, required this.child})
      : super(key: key);

  //旋转的“圈”数,一圈为360度，如0.25圈即90度
  final double turns;

  //过渡动画执行的总时长
  final int speed;
  final Widget child;

  @override
  State<TurnBox> createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    // 默认为0-1,可以通过lowerBound,upperBound 设置动画的value的最大最小值
    _controller.value = widget.turns;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed),
          curve: Curves.easeOut);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: widget.child);
  }
}

class TurnBoxApi extends StatefulWidget {
  const TurnBoxApi({Key? key}) : super(key: key);

  @override
  State<TurnBoxApi> createState() => _TurnBoxApiState();
}

class _TurnBoxApiState extends State<TurnBoxApi> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TurnBoxApi')),
      body: Center(
        child: Column(
          children: [
            TurnBox(
              turns: _turns,
              speed: 300,
              child: const Icon(
                Icons.refresh,
                size: 200,
              ),
            ),
            ElevatedButton(
              child: const Text("顺时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
            ),
            ElevatedButton(
              child: const Text("逆时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns -= .2;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
