import 'package:flutter/material.dart';

import '../tabs.dart';

final Map routes = {
  '/': (context) => const Tabs(),
};

onGenerateRoute() {
  return (RouteSettings settings) {
    final routeName = settings.name;
    final Function pageContentBuilder = routes[routeName];
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
