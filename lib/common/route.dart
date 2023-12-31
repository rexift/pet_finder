import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

final navigatorKey = GlobalKey<NavigatorState>();
NavigatorState get navigator => navigatorKey.currentState!;

PageRoute<T> buildRoute<T>(
  String name, {
  required WidgetBuilder builder,
  bool fullscreenDialog = false,
  bool maintainState = true,
  bool isInitialRoute = false,
}) {
  final settings = RouteSettings(
    name: name,
    // isInitialRoute: isInitialRoute, // deprecated
  );
  if (isInitialRoute) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? NoAnimationCupertinoPageRoute<T>(
            builder: builder,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog,
          )
        : NoAnimationMaterialPageRoute<T>(
            builder: builder,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog,
          );
  }
  return defaultTargetPlatform == TargetPlatform.iOS
      ? CupertinoPageRoute<T>(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        )
      : MaterialPageRoute<T>(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}

bool _isFirstTransitionDuration = false;

class NoAnimationCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  NoAnimationCupertinoPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Duration get transitionDuration {
    _isFirstTransitionDuration = !_isFirstTransitionDuration;
    // transitionDuration вызывается два раза на каждую анимацию;
    // для первого вызова обнуляю значение, для второго - возвращаю.
    return _isFirstTransitionDuration
        ? Duration.zero
        : Duration(milliseconds: 300);
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Duration get transitionDuration {
    _isFirstTransitionDuration = !_isFirstTransitionDuration;
    // transitionDuration вызывается два раза на каждую анимацию;
    // для первого вызова обнуляю значение, для второго - возвращаю.
    return _isFirstTransitionDuration
        ? Duration.zero
        : Duration(milliseconds: 300);
  }
}
