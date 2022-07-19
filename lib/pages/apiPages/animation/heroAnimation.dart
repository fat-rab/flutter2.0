import 'package:flutter/material.dart';

// hero指的是在路由之间飞行的widget,简单来说就是hero动画在路由切换的时候，有一个共享的widget可以在路由之间切换
class HeroAnimationApiA extends StatelessWidget {
  const HeroAnimationApiA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HeroAnimationApi')),
      body: Center(
        child: InkWell(
          child: Hero(
            tag: 'avatar', //指定唯一标识
            child: ClipOval(
              child: Image.asset("images/hun2.jpg", width: 50.0),
            ),
          ),
          onTap: () {
            Navigator.push(context, PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: Scaffold(
                    appBar: AppBar(title: const Text('HeroAnimationApiB')),
                    body: const HeroAnimationApiB()),
              );
            }));
          },
        ),
      ),
    );
  }
}

class HeroAnimationApiB extends StatelessWidget {
  const HeroAnimationApiB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'avatar', //标识必须一致
        child: Image.asset("images/hun2.jpg"),
      ),
    );
  }
}
