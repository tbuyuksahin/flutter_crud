import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/src/blocs/auth_bloc.dart';
import 'package:flutter_crud_firebase/src/models/user.dart';
import 'package:flutter_crud_firebase/src/styles/base.dart';
import 'package:flutter_crud_firebase/src/styles/colors.dart';
import 'package:flutter_crud_firebase/src/widgets/button.dart';
import 'package:flutter_crud_firebase/src/widgets/textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  final String userId;

  EditUser({this.userId});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);

    authBloc.userSaved.listen(
      (saved) {
        if (saved != null && saved == true && context != null) {
          Fluttertoast.showToast(
              msg: "Saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: AppColors.lightblue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        Navigator.pop(context);
      },
    );

    authBloc.userDelete.listen(
      (delete) {
        if (delete != null && delete == true && context != null) {
          Fluttertoast.showToast(
              msg: "Bilgileriniz Temizlendi",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: AppColors.lightblue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        Navigator.pop(context);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return FutureBuilder<User>(
      future: authBloc.fetchUser(widget.userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData && widget.userId != null) {
          return Scaffold(
            body: Center(
                child: (Platform.isIOS)
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator()),
          );
        }
        User existingUser;
        if (widget.userId != null) {
          //Edit Logic
          existingUser = snapshot.data;
          loadValues(authBloc, existingUser, authBloc.userId);
        } else {
          //Add Logic
          loadValues(authBloc, null, authBloc.userId);
        }
        return pageBody(authBloc, context, existingUser);
      },
    );
  }

  Widget pageBody(AuthBloc authBloc, BuildContext context, User existingUser) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/deneme11.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                StreamBuilder<bool>(
                  stream: authBloc.isUploading,
                  builder: (context, snapshot) {
                    return (!snapshot.hasData || snapshot.data == false)
                        ? Container()
                        : Center(
                            child: (Platform.isIOS)
                                ? CupertinoActivityIndicator()
                                : CircularProgressIndicator(),
                          );
                  },
                ),
                StreamBuilder<String>(
                    stream: authBloc.imageUrlPhoto,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == "")
                        return AppButton(
                          buttonType: ButtonType.DarkGray,
                          buttonText: 'Add Image',
                          onPressed: authBloc.pickImage,
                        );
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: BaseStyles.listPadding,
                            child: Image.network(snapshot.data),
                          ),
                          AppButton(
                            buttonType: ButtonType.DarkBlue,
                            buttonText: 'Resim Seç',
                            onPressed: authBloc.pickImage,
                          )
                        ],
                      );
                    }),
                StreamBuilder<String>(
                  stream: authBloc.name,
                  builder: (context, snapshot) {
                    return AppTextField(
                      helperText: "*Zorunlu alan",
                      maxLenght: 20,
                      hintText: 'İsim',
                      materialIcon: FontAwesomeIcons.user,
                      errorText: snapshot.error,
                      initialText:
                          (existingUser != null) ? existingUser.name : null,
                      onChanged: authBloc.changeName,
                    );
                  },
                ),
                StreamBuilder<String>(
                    stream: authBloc.lastName,
                    builder: (context, snapshot) {
                      return AppTextField(
                        maxLenght: 20,
                        helperText: "*Zorunlu alan",
                        hintText: 'Soyisim',
                        materialIcon: FontAwesomeIcons.user,
                        errorText: snapshot.error,
                        initialText: (existingUser != null)
                            ? existingUser.lastName
                            : null,
                        onChanged: authBloc.changeLastName,
                      );
                    }),
                StreamBuilder<String>(
                  stream: authBloc.age,
                  builder: (context, snapshot) {
                    return AppTextField(
                      helperText: "*Zorunlu alan",
                      textInputType: TextInputType.number,
                      hintText: 'age',
                      materialIcon: FontAwesomeIcons.baby,
                      errorText: snapshot.error,
                      initialText:
                          (existingUser != null) ? existingUser.age : null,
                      onChanged: authBloc.changeAge,
                    );
                  },
                ),
                StreamBuilder<String>(
                    stream: authBloc.profession,
                    builder: (context, snapshot) {
                      return AppTextField(
                        helperText: "*Zorunlu alan",
                        maxLenght: 30,
                        hintText: 'Meslek',
                        materialIcon: FontAwesomeIcons.addressCard,
                        errorText: snapshot.error,
                        initialText: (existingUser != null)
                            ? existingUser.profession
                            : null,
                        onChanged: authBloc.changeProfession,
                      );
                    }),
                StreamBuilder<String>(
                    stream: authBloc.school,
                    builder: (context, snapshot) {
                      return AppTextField(
                        maxLenght: 50,
                        helperText: "*Zorunlu alan",
                        hintText: 'Okul',
                        materialIcon: FontAwesomeIcons.university,
                        errorText: snapshot.error,
                        initialText:
                            (existingUser != null) ? existingUser.school : null,
                        onChanged: authBloc.changeSchool,
                      );
                    }),
                StreamBuilder<String>(
                    stream: authBloc.target,
                    builder: (context, snapshot) {
                      return AppTextField(
                        maxLenght: 400,
                        hintText:
                            'İnsanlara hayallerinizden, hedeflerinizden\n veya kısaca kendinizden bahsedebilirsiniz :)',
                        materialIcon: FontAwesomeIcons.infinity,
                        errorText: snapshot.error,
                        initialText:
                            (existingUser != null) ? existingUser.target : null,
                        onChanged: authBloc.changeTarget,
                      );
                    }),
                StreamBuilder<String>(
                    stream: authBloc.instagram,
                    builder: (context, snapshot) {
                      return AppTextField(
                        hintText: 'Instagram',
                        materialIcon: FontAwesomeIcons.instagram,
                        errorText: snapshot.error,
                        initialText: (existingUser != null)
                            ? existingUser.instagram
                            : null,
                        onChanged: authBloc.changeInstagram,
                      );
                    }),
                StreamBuilder<String>(
                    stream: authBloc.facebook,
                    builder: (context, snapshot) {
                      return AppTextField(
                        hintText: 'Facebook',
                        materialIcon: FontAwesomeIcons.facebook,
                        errorText: snapshot.error,
                        initialText: (existingUser != null)
                            ? existingUser.facebook
                            : null,
                        onChanged: authBloc.changeFacebook,
                      );
                    }),
                StreamBuilder<String>(
                    stream: authBloc.twitter,
                    builder: (context, snapshot) {
                      return AppTextField(
                        hintText: 'Twitter',
                        materialIcon: FontAwesomeIcons.twitter,
                        errorText: snapshot.error,
                        initialText: (existingUser != null)
                            ? existingUser.twitter
                            : null,
                        onChanged: authBloc.changeTwitter,
                      );
                    }),
                StreamBuilder<String>(
                    stream: authBloc.newMail,
                    builder: (context, snapshot) {
                      return AppTextField(
                        hintText: 'E-Mail',
                        materialIcon: FontAwesomeIcons.mailBulk,
                        errorText: snapshot.error,
                        initialText: (existingUser != null)
                            ? existingUser.newEmail
                            : null,
                        onChanged: authBloc.changeNewEmail,
                      );
                    }),
                StreamBuilder<bool>(
                  stream: authBloc.isValidSave,
                  builder: (context, snapshot) {
                    return AppButton(
                      buttonType: (snapshot.data == true)
                          ? ButtonType.DarkBlue
                          : ButtonType.Disabled,
                      buttonText: 'Profilimi Kaydet',
                      onPressed: authBloc.saveUserData,
                    );
                  },
                ),
                AppButton(
                  buttonText: 'Bilgilerimi Temizle',
                  onPressed: authBloc.deleteUserData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadValues(AuthBloc authBloc, User user, String userId) {
    authBloc.changeUser(user);
    authBloc.changeUserId(userId);

    if (user != null) {
      //Edit
      authBloc.changeName(user.name);
      authBloc.changeLastName(user.lastName);
      authBloc.changeAge(user.age);
      authBloc.changeProfession(user.profession);
      authBloc.changeSchool(user.school);
      authBloc.changeTarget(user.target);
      authBloc.changeInstagram(user.instagram);
      authBloc.changeImageUrl(user.imageUrl ?? '');
    } else {
      //Add
      authBloc.changeName(null);
      authBloc.changeLastName(null);
      authBloc.changeAge(null);
      authBloc.changeProfession(null);
      authBloc.changeSchool(null);
      authBloc.changeTarget(null);
      authBloc.changeInstagram(null);
      authBloc.changeImageUrl('');
    }
  }
}
