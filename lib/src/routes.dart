import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/edit_user.dart';
import 'screens/homepage.dart';
import 'screens/login.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (context) => Login());
      case "/home":
        return MaterialPageRoute(builder: (context) => HomePage());
      case "/editUser":
        return MaterialPageRoute(builder: (context) => EditUser());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editUser/')) {
          return MaterialPageRoute(
            builder: (context) => EditUser(
              userId: routeArray[2],
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => Login());
    }
  }

  static CupertinoPageRoute cupertinoRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return CupertinoPageRoute(builder: (context) => Login());
      case "/home":
        return CupertinoPageRoute(builder: (context) => HomePage());
      case "/editUser":
        return CupertinoPageRoute(builder: (context) => EditUser());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editUser/')) {
          return CupertinoPageRoute(
              builder: (context) => EditUser(
                    userId: routeArray[2],
                  ));
        }
        return CupertinoPageRoute(builder: (context) => Login());
    }
  }
}
