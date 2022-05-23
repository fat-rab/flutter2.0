import 'package:flutter/material.dart';

class GridViewApi extends StatelessWidget {
  const GridViewApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GridViewApi")),
      body: Container(
        child: const GridViewBuilderApi(),
      ),
    );
  }
}
//GridViewApi的参数和ListView基本抑制，重点关注gridDelegate即可，类型是SliverGridDelegate
// SliverGridDelegate是抽象类，子类需要实现这个抽象类来实现具体的布局算法
// flutter 提供了两个SliverGridDelegate的子类

//SliverGridDelegateWithFixedCrossAxisCount
// 实现了横轴为固定数量widget的算法
Widget gridView1() {
  return GridView(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // 横轴子元素数量
        crossAxisCount: 3,
        //子元素在横轴与主轴长度的比例（横轴/主轴），指定crossAxisCount之后，子元素在横轴的长度就确定了，
        // 通过childAspectRatio参数可以确定子元素在主轴的长度
        childAspectRatio: 2),
    children: const [
      Icon(Icons.ac_unit),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast)
    ],
  );
}

// SliverGridDelegateWithMaxCrossAxisExtent
// 实现了横轴子元素为固定最大长度的layout算法
Widget gridView2() {
  return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100, childAspectRatio: 2),
      children: const [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ]);
}

// GridView.count
// 内部使用了SliverGridDelegateWithFixedCrossAxisCount
Widget gridView3() {
  return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2.0,
      children: const [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ]);
}

// GridView.extent
// 内部使用了SliverGridDelegateWithMaxCrossAxisExtent
Widget gridView4() {
  return GridView.extent(
      maxCrossAxisExtent: 120,
      childAspectRatio: 2.0,
      children: const [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ]);
}

//GridView.builder
// 上述GridView需要列出所有的子元素,当子元素较多的就不使用了，此时需要使用GridView.builder()

class GridViewBuilderApi extends StatefulWidget {
  const GridViewBuilderApi({Key? key}) : super(key: key);

  @override
  _GridViewBuilderApiState createState() => _GridViewBuilderApiState();
}

class _GridViewBuilderApiState extends State<GridViewBuilderApi> {
  final List<IconData> _iconList = [];

  @override
  void initState() {
    _retrieveIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: _iconList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: 2.0),
        itemBuilder: (BuildContext context, int index) {
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
          if (index == _iconList.length - 1 && _iconList.length < 20) {
            _retrieveIcons();
          }
          return Icon(_iconList[index]);
        });
  }

  void _retrieveIcons() {
    Future.delayed(const Duration(milliseconds: 100)).then((e) {
      setState(() {
        _iconList.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }
}
