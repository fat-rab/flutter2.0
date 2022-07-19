import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureApi extends StatelessWidget {
  const GestureApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GestureApi')),
      body: _CustomGestureDetectorApi(),
    );
  }
}

// 单击双击，长按等等
class GestureDetectorApi1 extends StatefulWidget {
  const GestureDetectorApi1({Key? key}) : super(key: key);

  @override
  State<GestureDetectorApi1> createState() => _GestureDetectorApi1State();
}

class _GestureDetectorApi1State extends State<GestureDetectorApi1> {
  String _operation = "No Gesture detected!"; //保存事件名
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 150,
          color: Colors.blue,
          child: Text(
            _operation,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      // 同时监听单击事件和双击事件，当用户触发tap事件的时候，会有200ms左右的延迟，
      // 因为GestureDetector需要等待一段时间来确定是否是双击事件
      onTap: () {
        setState(() {
          _operation = '点击';
        });
      },
      onDoubleTap: () {
        setState(() {
          _operation = '双击';
        });
      },
      onLongPress: () {
        setState(() {
          _operation = '长按';
        });
      },
    );
  }
}

// 拖动，滑动
class GestureDetectorApi2 extends StatefulWidget {
  const GestureDetectorApi2({Key? key}) : super(key: key);

  @override
  State<GestureDetectorApi2> createState() => _GestureDetectorApi2State();
}

class _GestureDetectorApi2State extends State<GestureDetectorApi2> {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移
  @override
  Widget build(BuildContext context) {
    // Positioned必须是stack的子组件
    return Stack(
      children: [
        Positioned(
            left: _left,
            top: _top,
            child: GestureDetector(
              child: const CircleAvatar(
                child: const Text('A'),
              ),
              onPanDown: (DragDownDetails event) {
                // globalPosition 是相对于屏幕(并非父组件)的原点(左上角)的偏移量
                print('用户按下${event.globalPosition}');
              },
              onPanEnd: (DragEndDetails event) {
                // velocity代表用户抬起手指时候的滑行速度，常见用法是抬起手指的时候做一个减速动画
                print('X,Y轴速度${event.velocity}');
              },
              onPanUpdate: (DragUpdateDetails event) {
                // 用户手指滑动的时候更新偏移
                // delta指的是每次onPanUpdate事件的偏移亮
                setState(() {
                  _left += event.delta.dx;
                  _top += event.delta.dy;
                });
              },
              //通过这个事件可以只处理垂直移动
              // onVerticalDragUpdate: (DragUpdateDetails event){
              //   setState(() {
              //     _top += event.delta.dy;
              //   });
              // },
              // //通过这个事件可以只处理水平移动
              // onHorizontalDragUpdate: (DragUpdateDetails event){
              //   setState(() {
              //     _left += event.delta.dx;
              //   });
              // },
            ))
      ],
    );
  }
}

// 缩放
class GestureDetectorApi3 extends StatefulWidget {
  const GestureDetectorApi3({Key? key}) : super(key: key);

  @override
  State<GestureDetectorApi3> createState() => _GestureDetectorApi3State();
}

class _GestureDetectorApi3State extends State<GestureDetectorApi3> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
          child: Image.asset(
        'images/hun2.jpg',
        width: _width,
      )),
      // 缩放事件，还可以添加双击放大缩小一定倍数的图片等等
      onScaleUpdate: (ScaleUpdateDetails e) {
        // 缩放倍数 0.8~10
        _width = e.scale.clamp(0.8, 10);
      },
    );
  }
}

// GestureRecognizer
// GestureDetector 内部是使用一个或者多个GestureRecognizer，
// GestureRecognizer的作用是通过listener将原始的指针事件，转化为语义手势
// GestureDetector 可以接受一个子widget,GestureRecognizer是一个抽象类，一个手势对应一个GestureRecognizer的子类

class _GestureRecognizer extends StatefulWidget {
  const _GestureRecognizer({Key? key}) : super(key: key);

  @override
  State<_GestureRecognizer> createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<_GestureRecognizer> {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    // 使用GestureRecognizer后一定要调用其dispose()方法来释放资源（主要是取消内部的计时器）
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        const TextSpan(text: '你好'),
        TextSpan(
            text: 'flutter',
            style: TextStyle(
              fontSize: 30.0,
              color: _toggle ? Colors.blue : Colors.red,
            ),
            // .. 级联运算符
            recognizer: _tapGestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              })
      ])),
    );
  }
}

class _BothDirectionTest extends StatefulWidget {
  @override
  _BothDirectionTestState createState() => _BothDirectionTestState();
}

class _BothDirectionTestState extends State<_BothDirectionTest> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: const CircleAvatar(child: Text("A")),
            // 如果同时监听垂直和水平移动，会出现手势竞争，
            // 根据第一次移动的时候两个轴上的位移分量，来决定谁胜出
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}
// 手势冲突
// 监听水平和垂直事件的时候，不能够监听onPanUpdate，否则会报错
// 如果 监听水平或者垂直移动事件的时候，还需要监听手指抬起或者按下，会出现手势冲突
// 解决方法
// 1 将手指抬起和按下通过listener监听，剩余的通过GestureDetector写在listener的child里面
// 使用listener可以直接跳出GestureDetector手势识别的范畴
// 2 自定义手势识别Recognizer
// 由于手势竞争，失败的手势会调用手势的rejectGesture 表示手势竞争失败，那么可以重写rejectGesture方法，
// 来调用他的acceptGesture方法（相当于失败手势也调用竞争成功的方法）

class CustomTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //不，我不要失败，我要成功
    //super.rejectGesture(pointer);
    //宣布成功
    super.acceptGesture(pointer);
  }
}

//创建一个新的GestureDetector，用我们自定义的 CustomTapGestureRecognizer 替换默认的
RawGestureDetector customGestureDetector({
  GestureTapCallback? onTap,
  GestureTapDownCallback? onTapDown,
  Widget? child,
}) {
  return RawGestureDetector(
    child: child,
    gestures: {
      CustomTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
        () => CustomTapGestureRecognizer(),
        (detector) {
          detector.onTap = onTap;
        },
      )
    },
  );
}

class _CustomGestureDetectorApi extends StatefulWidget {
  @override
  _CustomGestureDetectorApiState createState() =>
      _CustomGestureDetectorApiState();
}

class _CustomGestureDetectorApiState extends State<_CustomGestureDetectorApi> {

  @override
  Widget build(BuildContext context) {
    // 替换 GestureDetector
    // 会同时打印1和2
    return customGestureDetector(
      onTap: () => print("2"),
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => print("1"),
          child: Container(
            width: 50,
            height: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
