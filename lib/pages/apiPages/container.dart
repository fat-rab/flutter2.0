import 'package:flutter/material.dart';

class ContainerApi extends StatelessWidget {
  const ContainerApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("容器类")),
      body: const FittedBoxWidget(),
    );
  }
}

// FittedBox
class FittedBoxWidget extends StatelessWidget {
  const FittedBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          wContainer(BoxFit.none),
          const Text('Flutter中国1'),
          wContainer(BoxFit.contain),
          const Text('Flutter中国2'),
        ],
      ),
    );
  }
}
Widget wContainer(BoxFit boxFit) {
  return Container(
    width: 50,
    height: 50,
    color: Colors.red,
    child: FittedBox(
      fit: boxFit,
      // 子容器超过父容器大小
      child: Container(width: 60, height: 70, color: Colors.blue),
    ),
  );
}
// 裁剪
class ClipWidget extends StatelessWidget {
  const ClipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset(
      "images/hun2.jpg",
      height: 100,
    );
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            avatar,
            ClipOval(
              child: avatar, //裁剪为椭圆形
            ),
            ClipRRect(
              child: avatar,
              borderRadius: BorderRadius.circular(10.0), //裁剪为圆角矩形
            ),
            ClipRect(
                //裁剪超出组件部分
                child: Align(
              alignment: Alignment.topCenter,
              widthFactor: 0.5, //宽度为原来的一半
              child: avatar,
            )),
            // 使用系统预制的自定义裁剪
            ClipPath.shape(shape: const StadiumBorder(), child: avatar),
            // 自定义裁剪,组件大小是layout阶段确定的，裁剪是绘制阶段确定的，所以裁剪不会影响组件大小
            Container(
              decoration: const BoxDecoration(color: Colors.red),
              child: ClipRect(
                clipper: MyClip1(),
                child: avatar,
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.red),
              child: ClipPath(
                clipper: MyClip2(),
                child: avatar,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//自定义裁剪2
class MyClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0); //设置裁剪起点
    path.lineTo(0, size.height); //裁剪路径
    path.lineTo(size.width, size.height); //裁剪路径
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// 自定义裁剪1
class MyClip1 extends CustomClipper<Rect> {
  @override
  // 返回裁剪区域
  Rect getClip(Size size) => const Rect.fromLTWH(10.0, 10.0, 100.0, 60.0);

  @override
  // 决定接口是否重新裁剪，如果裁剪区域不会发生变化，那么返回false,减少性能开销
  // 如果裁剪区域会发生变化（比如对裁剪区域执行一个动画效果），那么变化后需要返回true来重新执行裁剪
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 200.0, height: 150.0),
      margin: const EdgeInsets.only(top: 50.0, left: 120.0),
      decoration: const BoxDecoration(
          gradient: RadialGradient(
              //放射渐变
              colors: [Colors.red, Colors.orange],
              radius: 0.98, // 红色大小（放射起始点大小）
              center: Alignment.topLeft // 红色位置（放射起始点位置）
              ),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0.2, 0.2), //阴影与容器的距离，正数向右下角移动，负数向左上角移动
                blurRadius: 4.0, // 阴影模糊程度
                spreadRadius: 5.0 //阴影大小
                )
          ]),
      transform: Matrix4.rotationZ(0.2),
      alignment: Alignment.center,
      child: const Text(
        "ContainerWidget",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class TransformWidget extends StatelessWidget {
  const TransformWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          color: Colors.black,
          child: Transform(
            alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
            transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.deepOrange,
              child: const Text('Apartment for rent!'),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.translate(
            offset: const Offset(-20.0, 10.0), // 左移20，下移10
            child: const Text("translate"),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.rotate(
            angle: 20.0, // 顺时针旋转20度
            child: const Text("rotate"),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.scale(
            scale: 1.5, // 放大1.5倍
            child: const Text("scale"),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: RotatedBox(
            quarterTurns: 1, //int类型，旋转1/4圈
            child: Text("RotatedBox"),
          ),
        )
      ],
    );
  }
}

class DecorationWidget extends StatelessWidget {
  const DecorationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.red, Colors.orange.shade700]),
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 80),
        child: Text("button", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class PaddingWidget extends StatelessWidget {
  const PaddingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(padding: EdgeInsets.all(10), child: Text("hello,world1")),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text("hello,world2")),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Text("hello,world3")),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text("hello,world4+"))
      ],
    );
  }
}
