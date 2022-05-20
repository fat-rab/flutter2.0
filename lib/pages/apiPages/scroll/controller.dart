import 'package:flutter/material.dart';

class ControllerApi extends StatefulWidget {
  const ControllerApi({Key? key}) : super(key: key);

  @override
  _ControllerApiState createState() => _ControllerApiState();
}

class _ControllerApiState extends State<ControllerApi> {
  final ScrollController _controller = ScrollController();
  bool _showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // double get offset => position.pixels;
      // 一个ScrollController可以给多个滚动组件使用，如果是一对多，可以通过下面方法获取每个组件的滚动位置
      // print(_controller.positions.elementAt(0));
      //打印滚动位置
      if (_controller.offset < 1000 && _showToTopBtn == true) {
        setState(() {
          _showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && _showToTopBtn == false) {
        setState(() {
          _showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ControllerApi")),
      floatingActionButton: !_showToTopBtn
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                // 跳转到指定位置，并且会执行一个动画效果，如果使用jumpTo，则没有动画效果
                _controller.animateTo(.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
            ),
      body: Scrollbar(
        //如果使用自定义控制器并且使用Scrollbar，那么Scrollbar也需要加上ListView的控制器
        controller: _controller,
        child: ListView.builder(
            itemCount: 50,
            prototypeItem: const ListTile(title: Text("1")),
            controller: _controller,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("$index"));
            }),
      ),
    );
  }
}
