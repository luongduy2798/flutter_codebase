import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  // AppLocalizations get language => ComponentLanguageCode.language;

  navigate<T>(Widget screen,
      {bool pushAndRemoveUntil = false,
      bool isAnimated = false,
      bool rootNavigator = false}) {
    if (!!pushAndRemoveUntil) {
      return Navigator.pushAndRemoveUntil(
          this,
          isAnimated
              ? _createRoute(screen)
              : MaterialPageRoute<T>(builder: (BuildContext context) {
                  return screen;
                }),
          (route) => false);
    }

    return Navigator.of(this, rootNavigator: rootNavigator).push(isAnimated
        ? _createRoute(screen)
        : MaterialPageRoute<T>(builder: (BuildContext context) {
            return screen;
          }));
  }

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        });
  }

  navigateOverlay<T>(Widget screen) {
    return Navigator.push(
        this,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return screen;
            },
            transitionDuration: const Duration(milliseconds: 500),
            // reverseTransitionDuration: Duration(seconds: 500),
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: true,
            barrierLabel: '',
            maintainState: true,
            opaque: false,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            }));
  }

  navigateOpacity<T>(Widget screen, {bool pushAndRemoveUntil = false}) {
    if (!!pushAndRemoveUntil) {
      return Navigator.pushAndRemoveUntil(
          this,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return screen;
              },
              transitionDuration: const Duration(milliseconds: 200),
              // reverseTransitionDuration: Duration(seconds: 500),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }),
          (route) => false);
    }
    return Navigator.push(
        this,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return screen;
            },
            transitionDuration: const Duration(milliseconds: 200),
            // reverseTransitionDuration: Duration(seconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }));
  }

  void popToRoot() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get appPadding => 16;
  double get appBarHeight => AppBar().preferredSize.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
}
