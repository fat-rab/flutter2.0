import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//ListView
// ListView 适用于widget数量已知并且数量较少的时候，否则应该使用ListView.builder()
// ListView.separated 比ListView.builder多出一个分割线构造器
class InfiniteListView extends StatelessWidget {
  const InfiniteListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("listView")),
      body: const InfiniteListViewWidget(),
    );
  }
}

class InfiniteListViewWidget extends StatefulWidget {
  const InfiniteListViewWidget({Key? key}) : super(key: key);

  @override
  _InfiniteListViewWidgetState createState() => _InfiniteListViewWidgetState();
}

class _InfiniteListViewWidgetState extends State<InfiniteListViewWidget> {
  static const loadingTag = "##loading##"; //表尾标记
  final _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(title: Text("固定表头")),
        // 需要使用Expanded 自动拉伸ListView填充屏幕高度，否则会出现ListView无法确定高度边界的错误
        Expanded(
            child: ListView.separated(
          itemCount: _words.length,
          itemBuilder: (context, index) {
            //如果到了表尾
            if (_words[index] == loadingTag) {
              //不足100条，继续获取数据，需要减去loadingTag计算
              if (_words.length - 1 < 100) {
                //获取数据
                _retrieveData();
                //加载时显示loading
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                );
              } else {
                //已经加载了100条数据，不再获取数据。
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            }
            //显示单词列表项
            return ListTile(title: Text(_words[index]));
          },
          separatorBuilder: (context, index) => const Divider(height: .0),
        ))
      ],
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        //重新构建列表,在_words.length - 1的位置插入新的数据
        _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }
}
