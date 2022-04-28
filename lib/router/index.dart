import 'package:flutter/material.dart';

import '../tabs.dart';

final Map<String, Function> routes = {
  '/': (context) => const Tabs(),
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
