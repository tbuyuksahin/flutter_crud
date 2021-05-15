import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/src/blocs/auth_bloc.dart';
import 'package:flutter_crud_firebase/src/screens/pages.dart';
import 'package:provider/provider.dart';

import 'users.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  StreamSubscription _userSubscription;
  TabController controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      var authBloc = Provider.of<AuthBloc>(context, listen: false);
      _userSubscription = authBloc.user.listen((user) {
        if (user == null)
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TabBarView(
        children: [Pages(), Users()],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(color: Colors.black),
        indicatorColor: Colors.amber,
        controller: controller,
        tabs: [
          Tab(icon: Icon(Icons.home, color: Colors.amber)),
          Tab(icon: Icon(Icons.settings, color: Colors.amber)),
        ],
      ),
    );
  }
}
