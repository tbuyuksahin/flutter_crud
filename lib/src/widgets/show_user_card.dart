import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/src/styles/base.dart';
import 'package:flutter_crud_firebase/src/styles/colors.dart';
import 'package:flutter_crud_firebase/src/styles/text.dart';
import 'package:flutter_crud_firebase/src/widgets/social_media_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowUserCard extends StatelessWidget {
  final String age;
  final String name;
  final String school;
  final String target;
  final String twitter;
  final String lastName;
  final String newEmail;
  final String photoUrl;
  final String facebook;
  final String instagram;
  final String profession;

  const ShowUserCard({
    Key key,
    this.photoUrl,
    this.age,
    this.name,
    this.school,
    this.target,
    this.twitter,
    this.lastName,
    this.newEmail,
    this.facebook,
    this.instagram,
    this.profession,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("images/deneme4.jpg"))),
      child: Padding(
        padding: BaseStyles.userCardPadding,
        child: Column(
          children: [
            Expanded(
                flex: 1, child: Column(children: [userCardImage(context)])),
            SizedBox(height: 5),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userNameAndLastNameRow(),
                  userProfessionRow(),
                  userAgeAndSchool(),
                  infoText(),
                  userTargetRow(),
                  userSocialRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userCardImage(BuildContext context) {
    return (photoUrl != null && photoUrl != "")
        ? Flexible(
            flex: 6,
            child: (photoUrl != null && photoUrl != "")
                ? ClipRRect(
                    child: Image.network(photoUrl, fit: BoxFit.fill),
                    borderRadius:
                        BorderRadius.circular(BaseStyles.borderRadius))
                : Image.asset('images/deneme6.jpg', height: 100.0),
          )
        : Container();
  }

  Widget userNameAndLastNameRow() {
    return Flexible(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("       " ?? "Yaş", style: TextStyles.age),
          Flexible(
            flex: 8,
            child: Column(
              children: [
                Flexible(
                    child: Text(name ?? "İsim",
                        style: TextStyles.nameAndLastName)),
                Flexible(
                    child: Text(lastName ?? "Soyisim",
                        style: TextStyles.nameAndLastName)),
              ],
            ),
          ),
          Text(age ?? "Yaş", style: TextStyles.age),
        ],
      ),
    );
  }

  Widget userProfessionRow() {
    return Flexible(
      flex: 2,
      child: Text(profession ?? "Meslek", style: TextStyles.profession),
    );
  }

  Widget userAgeAndSchool() {
    return Flexible(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(school ?? "Okul", style: TextStyles.school),
        ],
      ),
    );
  }

  Widget userTargetRow() {
    return Flexible(
      flex: 4,
      child: Container(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Text(target ?? "", style: TextStyles.target);
          },
        ),
      ),
    );
  }

  Widget userSocialRow() {
    return Flexible(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSocialMediaWidget(
            socialMedia: instagram ?? "Instagram",
            icon: FontAwesomeIcons.instagram,
            iconColor: AppColors.instagram,
            style: TextStyles.instagram,
          ),
          AppSocialMediaWidget(
            socialMedia: facebook ?? "Facebook",
            icon: FontAwesomeIcons.facebook,
            iconColor: AppColors.facebook,
            style: TextStyles.facebook,
          ),
          AppSocialMediaWidget(
            socialMedia: twitter ?? "Twitter",
            icon: FontAwesomeIcons.twitter,
            iconColor: AppColors.twitter,
            style: TextStyles.twitter,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(newEmail ?? "E-mail adress", style: TextStyles.email),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoText() {
    return Row(
      children: [
        Text("Hayallerim / Hedeflerim", style: TextStyles.deneme),
      ],
    );
  }
}
