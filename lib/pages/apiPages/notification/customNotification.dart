import 'package:flutter/material.dart';

class CustomNotificationApi extends StatelessWidget {
  const CustomNotificationApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomNotificationApi')),
      body: const _NotificationTest(),
    );
  }
}

// 自定义通知
// 1 定义一个通知类，需要继承notification
// 2 分发通知,Notification 有一个dispatch(context)方法，用于分发通知
// context 是一个操作Element的接口，和Element树上的节点是对应的，通知会从context对应的Element节点网上冒泡
class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}

class _NotificationTest extends StatefulWidget {
  const _NotificationTest({Key? key}) : super(key: key);

  @override
  State<_NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<_NotificationTest> {
  String _msg = '';

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
        onNotification: (MyNotification notification) {
          setState(() {
            _msg += notification.msg;
          });
          // 返回true的时候阻止冒泡
          // false不阻止，如果父组件也监听了NotificationListener，也会调用
          return true;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_msg),
              // 需要使用按钮位置的context，
              // 如果直接使用build的context，则此时context是根context,无法向上冒泡分发到NotificationListener
              // ElevatedButton(
              //   onPressed: () => MyNotification("Hi").dispatch(context),
              //   child: Text("Send Notification"),
              // ),
              Builder(builder: (BuildContext context) {
                return ElevatedButton(
                    onPressed: () {
                      MyNotification('hi').dispatch(context);
                    },
                    child: const Text('btn'));
              })
            ],
          ),
        ));
  }
}
