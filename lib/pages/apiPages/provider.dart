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
              // Consumer的唯一必须参数是builder,当ChangeNotifier发生变化的时候（notifyListeners被调用的时候）
              // 所有相关的Consumer中的builder都会被调用
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
    var cart = context.read<CartModel>();
    return Column(
      children: [
        // Consumer必须放在ChangeNotifierProvider下面
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
              cart.add(Item(1, 1));
            },
            child: const Text('add')),
        ElevatedButton.icon(
            onPressed: () {
              // 如果不需要数据渲染ui但是还是需要访问数据，可以使用provider.of来访问
              // 并且设置listen为false,这样当notifyListeners，该widget并不会被重构
              // 效果与context.read<T>蕾丝
              // Provider.of<CartModel>(context, listen: false).removeAll();
              cart.removeAll();
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

class MyProviderApi extends StatelessWidget {
  const MyProviderApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyProviderApi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // Consumer looks for an ancestor Provider widget
            // and retrieves its model (Counter, in this case).
            // Then it uses that model to build widgets, and will trigger
            // rebuilds if the model is updated.
            Consumer<CartModel>(
              builder: (context, cart, child) =>
                  Text(
                    '${cart.totalPrice}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can access your providers anywhere you have access
          // to the context. One way is to use Provider.of<Counter>(context).
          //
          // The provider package also defines extension methods on context
          // itself. You can call context.watch<Counter>() in a build method
          // of any widget to access the current state of Counter, and to ask
          // Flutter to rebuild your widget anytime Counter changes.
          //
          // You can't use context.watch() outside build methods, because that
          // often leads to subtle bugs. Instead, you should use
          // context.read<Counter>(), which gets the current state
          // but doesn't ask Flutter for future rebuilds.
          //
          // Since we're in a callback that will be called whenever the user
          // taps the FloatingActionButton, we are not in the build method here.
          // We should use context.read().
          var counter = context.read<CartModel>();
          counter.add(Item(1, 1));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
