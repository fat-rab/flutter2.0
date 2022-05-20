import 'package:flutter/material.dart';

class LayOutApi extends StatelessWidget {
  const LayOutApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("layout")),
        body: const WrapWidget()
        // body:SizedBox(
        //   height: 200,
        //   width: 200,
        //   child: UnconstrainedBox(
        //     child: Container(height: 300, width: 300, color: Colors.red),
        //   ),
        // )
        );
  }
}


class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, const Text("A"));
    // Column在本示例中在水平方向的最大宽度为屏幕的宽度
    return Column(
      children: [
        // 限制宽度为190，小于 200
        SizedBox(width: 190, child: LayoutBuilderWidget(children: _children)),
        LayoutBuilderWidget(children: _children)
      ],
    );
  }
}

class LayoutBuilderWidget extends StatelessWidget {
  const LayoutBuilderWidget({Key? key, required this.children})
      : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 200) {
        return Column(children: children, mainAxisSize: MainAxisSize.min);
      } else {
        // 大于200，显示双列
        var _children = <Widget>[];
        for (var i = 0; i < children.length; i += 2) {
          if (i + 1 < children.length) {
            _children.add(Row(
              children: [children[i], children[i + 1]],
              mainAxisSize: MainAxisSize.min,
            ));
          } else {
            _children.add(children[i]);
          }
        }
        return Column(children: _children, mainAxisSize: MainAxisSize.min);
      }
    });
  }
}

class AlignWidget extends StatelessWidget {
  const AlignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: const Align(
        widthFactor: 2.0,
        // Align组件的宽高因子，乘以子组件的宽高得到Align组件的宽高
        heightFactor: 2.0,
        //偏移量Alignment(this.x, this.y), x=-1代表align的最左边，y=-1代表align的最上面
        // 坐标原点（用于计算偏移坐标）为Align的中心点
        alignment: Alignment(1.0, -1.0),
        //alignment: FractionalOffset(1.0, 1.0), //坐标原点为Align的左上角
        child: FlutterLogo(
          size: 60,
        ),
      ),
    );
  }
}

//层叠布局Stack
class StackWidget extends StatelessWidget {
  const StackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(), //尽可能铺满整个屏幕
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: <Widget>[
          const Positioned(
            left: 18.0,
            child: Text("I am Jack"),
          ),
          Container(
            child: const Text("Hello world",
                style: TextStyle(color: Colors.white)),
            color: Colors.red,
          ),
          const Positioned(
            top: 22.0,
            child: Text("Your friend"),
          )
        ],
      ),
    );
  }
}

//Flow流失布局
class FlowWidget extends StatefulWidget {
  const FlowWidget({Key? key}) : super(key: key);

  @override
  _FlowWidgetState createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: TestFlowDelegate(margin: const EdgeInsets.all(10.0)),
      children: <Widget>[
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.red,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.green,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.blue,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.yellow,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.brown,
        ),
        Container(
          width: 80.0,
          height: 80.0,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  //  简写
  TestFlowDelegate({this.margin = EdgeInsets.zero});

  // TestFlowDelegate({EdgeInsets margin = EdgeInsets.zero}) {
  //   this.margin = margin;
  // }

  double width = 0;
  double height = 0;

  // 如果子组件尺寸或者位置发生变化，需要通过paintChildren中的context.paintChild重绘
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return const Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

// Wrap流式布局
class WrapWidget extends StatelessWidget {
  const WrapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // 排序方向
      direction: Axis.horizontal,
      //主轴方向widget间隔
      spacing: 8.0,
      //纵轴方向间距
      runSpacing: 10.0,
      //沿主轴方向居中
      alignment: WrapAlignment.center,
      children: const [
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
          label: Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
          label: Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
          label: Text('Laurens'),
        ),
      ],
    );
  }
}

// 弹性布局
class FlexLayoutTestRoute extends StatelessWidget {
  const FlexLayoutTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Flex 可以沿着水平或者垂直防线排列自组件，Row,和Column都继承自Flex
        //Flex的两个子widget按1：2来占据水平空间
        Flex(
          direction: Axis.horizontal, //水平排序
          children: <Widget>[
            // Expanded必须在Flex的children参数中，否则会报错
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 100.0,
            //Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间
            child: Flex(
              direction: Axis.vertical, //垂直排列
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget columnWidget = Column(
  //主轴子组件排序，默认系统当前环境的文本方向(从左向右)
  textDirection: TextDirection.ltr,
  // 纵轴排序方式，默认为down，从上倒下排列，up为从下到上
  verticalDirection: VerticalDirection.up,
  //子组件在纵轴排序方式，和verticalDirection相互配合
  crossAxisAlignment: CrossAxisAlignment.start,
  children: const [
    Text(
      " hello world ",
      style: TextStyle(fontSize: 30),
    ),
    Text(" I am tom ")
  ],
);
Widget rowWidget = Row(
  //主轴子组件排序，默认系统当前环境的文本方向(从左向右)
  textDirection: TextDirection.ltr,
  // 纵轴排序方式，默认为down，从上倒下排列，up为从下到上
  verticalDirection: VerticalDirection.up,
  //子组件在纵轴排序方式，和verticalDirection相互配合
  crossAxisAlignment: CrossAxisAlignment.start,
  children: const [
    Text(
      " hello world ",
      style: TextStyle(fontSize: 30),
    ),
    Text(" I am tom ")
  ],
);
