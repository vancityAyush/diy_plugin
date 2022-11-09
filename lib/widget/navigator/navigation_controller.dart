import 'package:diy/widget/navigator/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomSheetNavigator extends GetxController {
  final Map<String, Widget> routes;
  final RxString currentRoute = "/".obs;

  final RxList<settings> _stack = <settings>[].obs;

  Widget get currentScreen => _stack.last.screen;

  BottomSheetNavigator(
      {String initialRoute = "/", dynamic arguments, required this.routes}) {
    pushNamed(initialRoute, arguments: arguments);
  }

  void pushNamed(String route, {dynamic arguments}) {
    assert(routes.containsKey(route));
    _stack.add(settings(routes[route]!, arguments));
  }

  bool pop() {
    if (_stack.length > 1) {
      _stack.removeLast();
      return true;
    }
    return false;
  }

  dynamic get arguments => _stack.last.arguments;

  void push(Widget screen, {dynamic arguments}) {
    final settings current = settings(screen, arguments);
    _stack.add(current);
  }
}
