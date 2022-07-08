import 'package:flutter/material.dart';
import '../pages/apiPages/asyncBuilder.dart';
import '../pages/apiPages/color.dart';
import '../pages/apiPages/dialog.dart';
import '../pages/apiPages/inheritedWidget.dart';
import '../pages/apiPages/layout.dart';
import '../pages/apiPages/button.dart';
import '../pages/apiPages/container.dart';
import '../pages/apiPages/form.dart';
import '../pages/apiPages/image.dart';
import '../pages/apiPages/progress.dart';
import '../pages/apiPages/provider.dart';
import '../pages/apiPages/scroll/index.dart';
import '../pages/apiPages/text.dart';
import '../pages/apiPages/theme.dart';
import '../pages/apiPages/valueListenable.dart';
import '../pages/apiPages/willPopScope.dart';
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
  "/scrollApi": (context) => const ScrollApi(),
  "/willPopScopeApi": (context) => const WillPopScopeApi(),
  "/inheritedWidgetAPi": (context) => const InheritedWidgetAPi(),
  "/providerApi": (context) => const ProviderApi(),
  '/colorApi': (context) => const ColorApi(),
  '/themeApi': (context) => const ThemeApi(), //
  '/valueListenableApi': (context) => const ValueListenableApi(),
  '/asyncBuilderApi': (context) => const AsyncBuilderApi(),
  '/dialogApi': (context) => const DialogApi(),
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
