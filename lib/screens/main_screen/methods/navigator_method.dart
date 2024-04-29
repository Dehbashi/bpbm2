import 'package:flutter/material.dart';

Widget navigatorMethod({
  required GlobalKey key,
  required int index,
  required Widget child,
  required int currentIndex,
}) {
  return key.currentState == null && currentIndex != index
      ? Container()
      : Navigator(
          key: key,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => Offstage(
              offstage: currentIndex != index,
              child: child,
            ),
          ),
        );
}
