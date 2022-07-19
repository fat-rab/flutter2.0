import 'package:flutter/material.dart';

class PointerEventApi extends StatefulWidget {
  const PointerEventApi({Key? key}) : super(key: key);

  @override
  State<PointerEventApi> createState() => _PointerEventApiState();
}

class _PointerEventApiState extends State<PointerEventApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PointerEventApi')),
      // 忽略指针事件
      // IgnorePointer 和AbsorbPointer
      // AbsorbPointer是吸收指针事件，可以指定指针事件，而IgnorePointer不行
      body: Listener(
        child: const AbsorbPointer(
          child: ListenerApi(),
        ),
        // 会打印up，但是使用IgnorePointer则不会打印
        onPointerUp: (event) {
          print('up');
        },
      ),
    );
  }
}

class ListenerApi extends StatefulWidget {
  const ListenerApi({Key? key}) : super(key: key);

  @override
  State<ListenerApi> createState() => _ListenerApiState();
}

class _ListenerApiState extends State<ListenerApi> {
  //event包含的信息
  // position 指针相对于全局坐标系的便宜
  // localPosition 指针相对于本身布局坐标的便宜
  // delta 两次指针移动事件（PointerMoveEvent）的距离
  // pressure 按压力度，如果手机不支持，那么值为1
  // orientation  指针移动方向，是一个角度值
  // behavior 决定子组件如何响应命中测试
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        child: Container(
          width: 200,
          height: 150,
          color: Colors.blue,
          alignment: Alignment.center,
          // ?? 空判断，如果_event?.localPosition为Null，则使用''
          child: Text('${_event?.localPosition ?? ''}'),
        ),
        onPointerDown: (PointerDownEvent event) {
          setState(() {
            _event = event;
          });
        },
        onPointerUp: (PointerUpEvent event) {
          setState(() {
            _event = event;
          });
        },
        onPointerMove: (PointerMoveEvent event) {
          setState(() {
            _event = event;
          });
        },
      ),
    );
  }
}
