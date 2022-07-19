import 'package:flutter/material.dart';

// 组合式组件
class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key,
      this.colors,
      this.width,
      this.height,
      this.borderRadius,
      this.onPressed,
      required this.child})
      : super(key: key);

  // 渐变色数组
  final List<Color>? colors;

  // 按钮宽高
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  //点击回调
  final GestureTapCallback? onPressed;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    // 设置默认渐变色
    List<Color> _colors =
        colors ?? [themeData.primaryColor, themeData.primaryColorDark];
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        // type标识组件类型，transparency=透明，使用水波纹和高亮颜色绘制。
        type: MaterialType.transparency,
        child: InkWell(
          // 设置水波纹颜色
          splashColor: _colors.last,
          // 设置高亮颜色
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButtonApi extends StatelessWidget {
  const GradientButtonApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GradientButtonApi')),
      body: Column(
        children: [
          GradientButton(
            colors: const [Colors.orange, Colors.red],
            height: 50.0,
            child: const Text("Submit"),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  onTap() {
    print("button click");
  }
}
