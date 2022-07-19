import 'package:flutter/cupertino.dart';
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
            ),
            ElevatedButton(
                onPressed: () {
                  showCustomDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("提示"),
                        content: const Text("您确定要删除当前文件吗?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("取消"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: const Text("删除"),
                            onPressed: () {
                              // 执行删除操作
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("自定义对话框")),
            ElevatedButton(
              child: const Text('复选框dialog'),
              onPressed: () async {
                bool? delete = await showDeleteConfirmDialog(context);
                if (delete == null) {
                  print('取消删除$delete');
                } else {
                  print('删除$delete');
                }
              },
            ),
            ElevatedButton(
              child: const Text('showModalBottomSheet'),
              onPressed: () async {
                int? index = await _showModalBottomSheet(context);
                print(index);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _showLoadingDialog(context);
                  // 一秒钟后关闭
                  Future.delayed(const Duration(seconds: 1),
                      () => {Navigator.of(context).pop()});
                },
                child: const Text('loadingDialog')),
            ElevatedButton(
                onPressed: () {
                  // DateTime? date = await _showDatePicker1(context);
                  // print('选择日期$date');
                  _showDatePicker1(context).then((value) => print('日期$value'));
                },
                child: const Text('日历1')),
            ElevatedButton(
                onPressed: () {
                  _showDatePicker2(context);
                },
                child: const Text('日历2'))
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
                child: const Text('取消')),
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
  // int? index = await showDialog<int>(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(child: Column(
  //         children: [
  //           const ListTile(title: Text('请选择')),
  //           Expanded(
  //               child: ListView.builder(
  //                   itemCount: 30,
  //                   prototypeItem: const ListTile(
  //                       title: Text('1条')
  //                   ),
  //                   itemBuilder: (context, int index) {
  //                     return ListTile(
  //                       title: Text('$index条'),
  //                       onTap: () {
  //                         Navigator.of(context).pop(index)
  //                       },
  //                     )
  //                   }
  //               )
  //           )
  //         ],
  //       ),)
  //     }
  // );
  // if (index != null) {
  //   print(index);
  // }
}

// 自定义dialog
Future<T?> showCustomDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  ThemeData? theme,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return Theme(data: theme, child: pageChild);
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

Future<bool?> showDeleteConfirmDialog(BuildContext context) {
  bool _withTree = false; // 默认复选框不选中
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('提示'),
          content: Column(
            children: [
              Row(
                children: [
                  const Text('是否删除子目录'),
                  // 通过Builder来获得构建Checkbox的`context`，
                  // 这是一种常用的缩小`context`范围的方式
                  Builder(
                    builder: (BuildContext context) {
                      return Checkbox(
                        value: _withTree,
                        onChanged: (bool? value) {
                          // 通过 markNeedsBuild 将checkbox标记为dirty，让flutter进行更新
                          (context as Element).markNeedsBuild();
                          _withTree = !_withTree;
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_withTree);
                },
                child: const Text('删除'))
          ],
        );
      });
}

//showModalBottomSheet
Future<int?> _showModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
            itemCount: 5,
            prototypeItem: const ListTile(title: Text('第1')),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('第$index'),
                onTap: () {
                  Navigator.of(context).pop(index);
                },
              );
            });
      });
}

// loadingDialog
Future<bool?> _showLoadingDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        // return AlertDialog(
        //   content: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: const [
        //       CircularProgressIndicator(),
        //       Padding(
        //           padding: EdgeInsets.only(top: 26.0),
        //           child: Text('正在加载，请稍后....'))
        //     ],
        //   ),
        // );
        // showDialog 给对话框做了最小尺寸的约束，如果想要减少dialog的宽度，可以使用UnconstrainedBox抵消约束
        return UnconstrainedBox(
            constrainedAxis: Axis.vertical, // 横向或者纵向保留约束
            child: SizedBox(
              width: 280,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    Padding(
                        padding: EdgeInsets.only(top: 26.0),
                        child: Text('正在加载，请稍后....'))
                  ],
                ),
              ),
            ));
      });
}

// Material风格日历选择器
Future<DateTime?> _showDatePicker1(BuildContext context) {
  var date = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: date, //初始化时间，通常情况下设置为当前时间
    firstDate: date, //日期选择的开始时间，之前的时间不可选
    // 未来30天可选
    lastDate: date.add(const Duration(days: 30)),
  );
}

//ios风格日历，通常通过showCupertinoModalPopup在底部显示CupertinoDatePicker
Future<DateTime?> _showDatePicker2(BuildContext context) {
  var date = DateTime.now();
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: date,
          maximumDate: date.add(
            const Duration(days: 30),
          ),
          maximumYear: date.year + 1,
          onDateTimeChanged: (DateTime value) {
            print(value);
          },
        ),
      );
    },
  );
}
