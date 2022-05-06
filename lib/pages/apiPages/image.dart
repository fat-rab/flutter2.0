import 'package:flutter/material.dart';

class ImageApi extends StatelessWidget {
  const ImageApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage("images/hun2.jpg"),
                  width: 200,
                ),
                Image.asset(
                  "images/hun2.jpg",
                  width: 300,
                ),
                // 从网络加载图片
                const Image(
                  image: NetworkImage(
                      "https://avatars.githubusercontent.com/u/55075519?v=4"),
                ),
                Image.network(
                  "https://avatars.githubusercontent.com/u/55075519?v=4",
                  width: 300,
                ),
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                // 使用iconfont图标
                const Icon(
                  MyIcons.fenLei,
                  color: Colors.yellow,
                )
              ],
            ),
          ),
        ));
  }
}
// 为了方便使用，将icon-font图标定义为类中的静态变量
class MyIcons {
  // 59223 是icon的unicode_decimal
  // matchTextDirection 匹配文本方向，一般情况都是true
  static const IconData fenLei =
      IconData(59223, fontFamily: 'myIcon', matchTextDirection: true);
}
