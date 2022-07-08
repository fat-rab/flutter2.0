import 'package:flutter/material.dart';

class AsyncBuilderApi extends StatefulWidget {
  const AsyncBuilderApi({Key? key}) : super(key: key);

  @override
  State<AsyncBuilderApi> createState() => _AsyncBuilderApiState();
}

class _AsyncBuilderApiState extends State<AsyncBuilderApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AsyncBuilder')),
      body: const Center(child: StreamBuilderApi()),
    );
  }
}

Future<String> mockNetworkData() async {
  return Future.delayed(const Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

class FutureBuilderAPi extends StatelessWidget {
  const FutureBuilderAPi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mockNetworkData(),
        // snapshot包含了当前请求的任务信息和任务结果
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // connectionState是枚举
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('error${snapshot.error}');
            } else {
              return Text(snapshot.data);
            }
          } else {
            return const CircularProgressIndicator();
          }
        }
        // 初始数据
        //initialData:''
        );
  }
}

Stream<int> counter() {
  return Stream.periodic(const Duration(seconds: 1), (i) => i);
}

class StreamBuilderApi extends StatelessWidget {
  const StreamBuilderApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: counter(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('没有Stream');
            case ConnectionState.waiting:
              return const Text('等待数据...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return const Text('Stream 已关闭');
          }
        });
  }
}
