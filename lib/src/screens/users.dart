import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/src/blocs/auth_bloc.dart';
import 'package:flutter_crud_firebase/src/models/user.dart';
import 'package:flutter_crud_firebase/src/styles/appbar.dart';
import 'package:flutter_crud_firebase/src/widgets/appbar_button.dart';
import 'package:flutter_crud_firebase/src/widgets/card.dart';
import 'package:provider/provider.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);

    Widget pageBody(AuthBloc authBloc, BuildContext context, String userId) {
      return StreamBuilder<List<User>>(
        stream: authBloc.fetchUserId(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return (Platform.isIOS)
                ? CupertinoActivityIndicator()
                : Center(child: CircularProgressIndicator());

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              shape: AppBarStyles.appBarDecorationRight,
              actions: [
                AppBarButton(
                    text: "Çıkış",
                    icon: Icons.exit_to_app,
                    onTap: authBloc.logout)
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/deneme6.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var users = snapshot.data[index];
                        return GestureDetector(
                          child: AppCard(
                            name: users.name ?? "Isim",
                            lastName: users.lastName ?? "Soyisim",
                            age: users.age ?? "Yas",
                            profession: users.profession ?? "Meslek",
                            imageUrl: users.imageUrl ?? "Resim",
                            school: users.school ?? "Okul",
                            target: users.target ?? "Hayallerim",
                            instagram: users.instagram ?? "Instagram",
                            twitter: users.twitter ?? "Twitter",
                            facebook: users.facebook ?? "Facebook",
                            newEmail: users.newEmail ?? "E-mail",
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed('/editUser/${users.userId}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return pageBody(authBloc, context, authBloc.userId);
  }
}
