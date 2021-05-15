import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/src/screens/homepage.dart';
import 'package:flutter_crud_firebase/src/services/firestore_service.dart';
import 'package:flutter_crud_firebase/src/styles/colors.dart';
import 'package:provider/provider.dart';

import 'blocs/auth_bloc.dart';
import 'routes.dart';
import 'screens/login.dart';
import 'styles/text.dart';

final authBloc = AuthBloc();
final firestoreService = FirestoreService();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => authBloc),
      FutureProvider(create: (context) => authBloc.isLoggedIn()),
    ], child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);

    if (Platform.isIOS) {
      return CupertinoApp(
          home: (isLoggedIn == null)
              ? loadingScreen(true)
              : (isLoggedIn == true)
                  ? HomePage()
                  : Login(),
          onGenerateRoute: Routes.cupertinoRoutes,
          theme: CupertinoThemeData(
              primaryColor: AppColors.straw,
              scaffoldBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                  tabLabelTextStyle: TextStyles.suggestion)));
    } else {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: (isLoggedIn == null)
              ? loadingScreen(false)
              : (isLoggedIn == true)
                  ? HomePage()
                  : Login(),
          onGenerateRoute: Routes.materialRoutes,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white));
    }
  }

  Widget loadingScreen(bool isIOS) {
    return (isIOS)
        ? CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
