import 'package:flutter/material.dart';

class ProgressApi extends StatefulWidget {
  const ProgressApi({Key? key}) : super(key: key);

  @override
  _ProgressApiState createState() => _ProgressApiState();
}

class _ProgressApiState extends State<ProgressApi>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, //需要混入SingleTickerProviderStateMixin 提供动画帧计时/触发器
        duration: const Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {
        // 通过这里改变状态执行动画
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          //LinearProgressIndicator和CircularProgressIndicator 默认充满父组件，可以用来调节大小
          // 如果不指定value，则进度条会执行一个循环动画
          SizedBox(
            height: 20,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
          ),
          const SizedBox(
            height: 100,
          ),
          // 动画效果
          LinearProgressIndicator(
            value: _animationController.value,
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
          ),
          const SizedBox(
            height: 100,
          ),
          CircularProgressIndicator(
            strokeWidth: 7.0, //调节粗细
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
          ),
          const SizedBox(
            height: 100,
          ),
          CircularProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
          ),
        ],
      ),
    );
  }
}
