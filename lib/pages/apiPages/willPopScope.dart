import 'package:flutter/material.dart';

// 为了避免用户误触返回键，可以使用WillPopScope
// onWillPop返回一个Future,如果为true则返回，否则不返回
class WillPopScopeApi extends StatefulWidget {
  const WillPopScopeApi({Key? key}) : super(key: key);

  @override
  _WillPopScopeApiState createState() => _WillPopScopeApiState();
}

class _WillPopScopeApiState extends State<WillPopScopeApi> {
  DateTime? _lastPressedAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("WillPopScopeApi"),
          ),
          body: const Text('123'),
        ),
        // 返回值是Future<bool>
        onWillPop: () async {
          // 只有1s内连续点击两次才会返回
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  const Duration(seconds: 1)) {
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        });
  }
}
