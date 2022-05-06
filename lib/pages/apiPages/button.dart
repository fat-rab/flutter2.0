import 'package:flutter/material.dart';

class ButtonApi extends StatefulWidget {
  const ButtonApi({Key? key}) : super(key: key);

  @override
  _ButtonApiState createState() => _ButtonApiState();
}

class _ButtonApiState extends State<ButtonApi> {
  final List<bool> _boolList = [false, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("button")),
      body: Column(
        children: [
          const ElevatedButton(
            child: Text("disabledButton"),
            onPressed: null, // onPressed为null，则按钮禁用
          ),
          ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 20)), //字体大小
                foregroundColor:
                    MaterialStateProperty.all(Colors.yellow) // 字体颜色
                ),
            child: const Text("ElevatedButton"),
            onPressed: () {},
          ),
          TextButton(child: const Text("TextButton"), onPressed: () {}),
          OutlinedButton(child: const Text("OutlinedButton"), onPressed: () {}),
          // 图标按钮
          IconButton(icon: const Icon(Icons.thumb_up), onPressed: () {}),
          ToggleButtons(
            isSelected: _boolList,
            children: const <Widget>[
              Icon(Icons.local_cafe),
              Icon(Icons.fastfood),
              Text("test")
            ],
            onPressed: (index) {
              setState(() {
                _boolList[index] = !_boolList[index];
              });
            },
          ),
          // 带图标的文字按钮
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text("发送"),
            onPressed: () {},
          ),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("添加"),
            onPressed: () {},
          ),
          TextButton.icon(
            icon: const Icon(Icons.info),
            label: const Text("详情"),
            onPressed: () {},
          ),
          // 悬浮按钮
          // FloatingActionButton的heroTag是一个默认值，不能出现重复
          // 所以当一个页面中出现多个FloatingActionButton时，需要手动定义heroTag
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
          FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text("创建"),
              heroTag: "add-1",
              onPressed: () {})
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "back",
        child: const Text('返回'),
        onPressed: () {
          Navigator.pop(context);
          //Navigator.of(context).pop();
        },
      ),
    );
  }
}
