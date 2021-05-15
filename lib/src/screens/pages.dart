import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_crud_firebase/src/models/user.dart';
import 'package:flutter_crud_firebase/src/styles/appbar.dart';
import 'package:flutter_crud_firebase/src/widgets/appbar_button.dart';
import 'package:flutter_crud_firebase/src/widgets/info_cards.dart';
import 'package:flutter_crud_firebase/src/widgets/show_user_card.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  List<User> _tumKullanicilar;
  bool _isLoading = false;
  bool _hasMore = true;
  int _getirilecekElemanSayisi = 1;
  User _ensonGetirilenUser;
  PageController pageController;

  double viewportFraction = 0.8;
  double pageOffset = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getUsers(_ensonGetirilenUser);
    });

    pageController =
        PageController(viewportFraction: viewportFraction, initialPage: 0);
    pageController.addListener(
      () {
        if (pageController.position.atEdge) {
          if (pageController.position == 0) {
          } else {
            getUsers(_ensonGetirilenUser);
          }
        }
        setState(() {
          pageOffset = pageController.page;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: AppBarButton(icon: Icons.all_inclusive),
          actions: [InfoCards()],
          backgroundColor: Colors.black,
          shape: AppBarStyles.appBarDecorationLeft,
        ),
        body: pageBody(context),
      );
    }
  }

  Widget pageBody(BuildContext context) {
    return _tumKullanicilar == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : kullaniciListesiniOlustur();
  }

  kullaniciListesiniOlustur() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("images/deneme4.jpg"))),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              itemCount: _tumKullanicilar.length + 1,
              itemBuilder: (context, index) {
                double scale = max(viewportFraction,
                    (1 - (pageOffset - index).abs()) + viewportFraction);
                if (index == _tumKullanicilar.length) {
                  return progressIndicatior();
                }
                return _userListeElemani(scale, index);
              },
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  height: 50,
                  child: Text("Reklam"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _userListeElemani(double scale, int index) {
    var onakiUser = _tumKullanicilar[index];

    return Padding(
      padding: EdgeInsets.only(
        right: 10,
        left: 20,
        top: 50 - scale * 25,
      ),
      child: ShowUserCard(
        photoUrl: onakiUser.imageUrl,
        name: onakiUser.name,
        lastName: onakiUser.lastName,
        age: onakiUser.age,
        profession: onakiUser.profession,
        school: onakiUser.school,
        target: onakiUser.target,
        instagram: onakiUser.instagram,
        facebook: onakiUser.facebook,
        twitter: onakiUser.twitter,
        newEmail: onakiUser.newEmail,
      ),
    );
  }

  getUsers(User sonGetirilenUser) async {
    if (!_hasMore) {
      print("Getirilecek eleman kalmadı");
      return;
    }
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    QuerySnapshot querySnapshot;
    if (sonGetirilenUser == null) {
      print("ilk Defa Kullanıcılar getiriliyor");
      querySnapshot = await Firestore.instance
          .collection("users")
          .orderBy("name")
          .limit(_getirilecekElemanSayisi)
          .getDocuments();
      _tumKullanicilar = [];
    } else {
      print("Sonraki kullanıcılar getiriliyor");
      querySnapshot = await Firestore.instance
          .collection("users")
          .orderBy("name")
          .startAfter([sonGetirilenUser.name])
          .limit(_getirilecekElemanSayisi)
          .getDocuments();
//      await Future.delayed(Duration(milliseconds: 300));
    }

    if (querySnapshot.documents.length < _getirilecekElemanSayisi) {
      _hasMore = false;
    }

    for (DocumentSnapshot snapshot in querySnapshot.documents) {
      User tekUser = User.fromFirestore(snapshot.data);
      _tumKullanicilar.add(tekUser);
      print("Getirilen user id" + tekUser.userId);
    }
    _ensonGetirilenUser = _tumKullanicilar.last;
    print("En Son getirilen user id " + _ensonGetirilenUser.userId);
    setState(() {
      _isLoading = false;
    });
  }

  progressIndicatior() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Opacity(
        opacity: _isLoading ? 1 : 0,
        child: Center(
          child: _isLoading ? CircularProgressIndicator() : null,
        ),
      ),
    );
  }
}
