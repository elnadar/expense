import 'package:flutter/material.dart';

import '../pages/pages.dart';

Map<String, Widget> routes = {
  "/": const ExpensesPage(),
  "/404 ": const Error404Page()
};

Route<dynamic>? onGenerateRoute(settings) {
  if (routes.containsKey(settings.name)) {
    return MaterialPageRoute(builder: (context) => routes[settings.name]!);
  } else {
    debugPrint(settings.name);
    return MaterialPageRoute(builder: (context) => routes["/404"]!);
  }
}
