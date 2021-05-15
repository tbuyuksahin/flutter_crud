import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/src/styles/base.dart';
import 'package:flutter_crud_firebase/src/styles/colors.dart';
import 'package:flutter_crud_firebase/src/styles/text.dart';
import 'package:intl/intl.dart';

class AppCard extends StatelessWidget {
  final String age;
  final String name;
  final String school;
  final String target;
  final String twitter;
  final String lastName;
  final String newEmail;
  final String facebook;
  final String instagram;
  final String profession;
  final String imageUrl;

  final formatCurrency = NumberFormat.simpleCurrency();

  AppCard({
    this.age,
    this.lastName,
    this.name,
    this.profession,
    this.imageUrl,
    this.school,
    this.target,
    this.twitter,
    this.newEmail,
    this.facebook,
    this.instagram,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: BaseStyles.listPadding,
      padding: BaseStyles.listPadding,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/deneme6.jpg"), fit: BoxFit.cover),
          boxShadow: BaseStyles.boxShadow,
          border: Border.all(
            color: AppColors.darkblue,
            width: BaseStyles.borderWidth,
          ),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(BaseStyles.borderRadius)),
                  child: (imageUrl != null && imageUrl != "")
                      ? ClipRRect(
                          child: Image.network(imageUrl, fit: BoxFit.fill),
                          borderRadius:
                              BorderRadius.circular(BaseStyles.borderRadius))
                      : Image.asset('images/deneme6.jpg', height: 100.0),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, style: TextStyles.subtitle),
                  Text(lastName, style: TextStyles.subtitle),
                ],
              ),
              SizedBox(height: 8),
              Text(age, style: TextStyles.subtitle),
              SizedBox(height: 8),
              Text(profession, style: TextStyles.subtitle),
              SizedBox(height: 8),
              Text(school, style: TextStyles.subtitle),
              SizedBox(height: 8),
              Text(instagram, style: TextStyles.subtitle),
              SizedBox(height: 8),
              Text(twitter, style: TextStyles.subtitle),
              SizedBox(height: 8),
              Text(facebook, style: TextStyles.subtitle),
              SizedBox(height: 8),
              Text(newEmail, style: TextStyles.subtitle),
            ],
          ),
          SizedBox(height: 10),
          Text(target, style: TextStyles.subtitle),
        ],
      ),
    );
  }
}
