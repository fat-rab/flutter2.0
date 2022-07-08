import 'package:flutter/material.dart';

class DialogApi extends StatelessWidget {
  const DialogApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DialogAPi')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("对话框1"),
              onPressed: () async {
                //弹出对话框并等待其关闭
                bool? delete = await showAlertDialog(context);
                if (delete == null) {
                  print("取消删除");
                } else {
                  print("已确认删除");
                  //... 删除文件
                }
              },
            ),
            ElevatedButton(
              child: const Text("对话框2"),
              onPressed: () async {
                //弹出对话框并等待其关闭
                int? result = await showSimpleDialog(context);
                print(result);
              },
            ),
            ElevatedButton(
              child: const Text("对话框3"),
              onPressed: () {
                showDialogApi(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
// AlertDialog和SimpleDialog都是通过showDialog方法渲染出来的
//AlertDialog

Future<bool?> showAlertDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: const Text('提示'),
          content: const Text('是否确定删除当前文件'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  //关闭对话框
                  Navigator.of(context).pop();
                },
                child: const Text('确定')),
            ElevatedButton(
                onPressed: () {
                  //关闭对话框并返回true
                  Navigator.of(context).pop(true);
                },
                child: const Text('取消'))
          ],
        );
      });
}

Future<int?> showSimpleDialog(BuildContext context) {
  return showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(title: const Text('选择语言'), children: <Widget>[
          // 类似 TextButton，只不过文案是左对齐，而且padding 比较小
          SimpleDialogOption(
            child: const Text('中文'),
            onPressed: () {
              Navigator.pop(context, 1);
            },
          ),
          SimpleDialogOption(
            child: const Text('英文'),
            onPressed: () {
              Navigator.pop(context, 2);
            },
          )
        ]);
      });
}

// AlertDialog和SimpleDialog都是通过子组件的实际尺寸来调整自身尺寸，所以子组件不能是延迟加载的组件模型
// 如果需要展示ListView这种直接使用Dialog类

Future<void> showDialogApi(BuildContext context) async {
  int? index = await showDialog<int>(
      context: context,
      builder: (context) {
        var child = Column(
          children: [
            const ListTile(title: Text('请选择')),
            Expanded(
                child: ListView.builder(
                    itemCount: 30,
                    prototypeItem: const ListTile(
                        title: Text('1条')
                    ),
                    itemBuilder: (context, int index) {
                      return ListTile(
                        title: Text('$index条'),
                        onTap: () {
                          Navigator.of(context).pop(index)
                        },
                      )
                    }
                )
            )
          ],
        )
        return Dialog(child: child,)
      }
  );
  if (index != null) {
    print(index);
  }
}