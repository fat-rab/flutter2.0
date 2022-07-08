import 'package:flutter/material.dart';

// InheritedWidget和provider提供了从上到下的共享数据方式，但是很多场景并不是从上到下的，
// 可以使用ValueListenableBuilder来实现横向或者从下到上的数据共享
class ValueListenableApi extends StatefulWidget {
  const ValueListenableApi({Key? key}) : super(key: key);

  @override
  State<ValueListenableApi> createState() => _ValueListenableApiState();
}

class _ValueListenableApiState extends State<ValueListenableApi> {
  // ValueNotifier 实现了ValueListenable<T>
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ValueListenableApi')),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _counter,
          builder: (context, int value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [child!, Text(value.toString())],
            );
          },
          child: const Text('点击次数'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter.value++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
