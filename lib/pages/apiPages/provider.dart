import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderApi extends StatefulWidget {
  const ProviderApi({Key? key}) : super(key: key);

  @override
  _ProviderApiState createState() => _ProviderApiState();
}

class _ProviderApiState extends State<ProviderApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ProviderApi")),
      // 通过 ChangeNotifierProvider 向其子孙节点暴露一个ChangeNotifier实例， 它属于 provider package。
      // 如果想要使用更多的provider可以使用MultiProvider
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChangeNotifierProvider(
              create: (context) => CartModel(),
              child: const MyPage(),
            )
          ],
        ),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  该方法由provider注入，直接返回 T，不会监听改变
    // var cart = context.read<CartModel>();
    return Column(
      children: [
        // Consumer必须放在ChangeNotifierProvider下面
        // Consumer的唯一必须参数是builder,当ChangeNotifier发生变化的时候（notifyListeners被调用的时候）
        // 所有相关的Consumer中的builder都会被调用
        Consumer<CartModel>(
          builder: (context, cart, child) {
            return Column(
              children: [
                //child 为 通过下面child参数传入的widget
                if (child != null) child,
                Text('total price ${cart.totalPrice}'),
              ],
            );
          },
          // 可以通过这个渲染一些不需要rebuild的widget
          child: const Text('SomeExpensiveWidget'),
        ),
        ElevatedButton(
            onPressed: () {
              // cart.add(Item(1, 1));
              // 如果不需要数据渲染ui但是还是需要访问数据，如果使用 Consumer<CartModel>的话有点浪费
              // 可以使用provider.of来访问并且设置listen为false,这样当notifyListeners，该widget并不会被重构
              // 效果与context.read<T>类似
              Provider.of<CartModel>(context, listen: false).add(Item(1, 1));
            },
            child: const Text('add')),
        ElevatedButton.icon(
            onPressed: () {
              // cart.removeAll();
              Provider.of<CartModel>(context, listen: false).removeAll();
            },
            icon: const Icon(Icons.clear),
            label: const Text('清空'))
      ],
    );
  }
}

class Item {
  double price;
  int count;

  Item(this.count, this.price);
}

// ChangeNotifier用于向监视器发送通知。换言之如果被定义为ChangeNotifier，可以订阅它的状态变化
class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  // 创建一个禁止修改的items，但是修改_items可以改变items
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.length * 42;

  void add(Item item) {
    _items.add(item);
    // 当模型变化并且需要通知更新Ui的时候可以调用notifyListeners方法
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
