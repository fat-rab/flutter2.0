import 'package:flutter/material.dart';
import 'package:myapp/pages/errorPages/404.dart';
import '../router/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', //app名称
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, //去除右上角DEBUG 标记
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute(),
      onUnknownRoute: (RouteSettings routeSettings){
        return MaterialPageRoute(builder: (context){
          return const ErrorPage();
        });
      },
    );
  }
}
