import 'package:flutter/material.dart';
import 'package:myapp/pages/apiPages/layout.dart';
import '../pages/apiPages/button.dart';
import '../pages/apiPages/container.dart';
import '../pages/apiPages/form.dart';
import '../pages/apiPages/image.dart';
import '../pages/apiPages/progress.dart';
import '../pages/apiPages/text.dart';
import '../tabs.dart';

final Map<String, Function> routes = {
  '/': (context) => const Tabs(),
  "/textApi": (context) => const TextApi(),
  "/buttonApi": (context) => const ButtonApi(),
  "/imageApi": (context) => const ImageApi(),
  "/formApi": (context) => const FormApi(),
  "/progressApi": (context) => const ProgressApi(),
  "/layoutApi": (context) => const LayOutApi(),
  "/containerApi": (context) => const ContainerApi(),
  // '/statelessRoutePage': (context, {arguments}) =>
  //     StatelessRoutePage(arguments: arguments), //无状态组件传参
  // '/statefulRoute': (context, {arguments}) => //有状态组件传参
  // StatefulRoutePage(arguments: arguments),
};

onGenerateRoute() {
  return (RouteSettings settings) {
    final routeName = settings.name;
    final pageContentBuilder = routes[routeName];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments));
        return route;
      } else {
        final route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context),
        );
        return route;
      }
    }
  };
}
