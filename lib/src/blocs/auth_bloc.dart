import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud_firebase/src/models/user.dart';
import 'package:flutter_crud_firebase/src/services/firebase_storage_service.dart';
import 'package:flutter_crud_firebase/src/services/firestore_service.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  //user data
  final _name = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();
  final _age = BehaviorSubject<String>();
  final _profession = BehaviorSubject<String>();
  final _school = BehaviorSubject<String>();
  final _target = BehaviorSubject<String>();
  final _instagram = BehaviorSubject<String>();
  final _facebook = BehaviorSubject<String>();
  final _twitter = BehaviorSubject<String>();
  final _newMail = BehaviorSubject<String>();
  //email and password
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  //image - photo
  final _imageUrlPhoto = BehaviorSubject<String>();
  final _isUploading = BehaviorSubject<bool>();
  //saved
  final _userSaved = PublishSubject<bool>();
  final _userDelete = PublishSubject<bool>();
  final _user = BehaviorSubject<User>();
  final _errorMessage = BehaviorSubject<String>();
  final _userIdEdit = BehaviorSubject<String>();
  final _userEdit = BehaviorSubject<User>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirestoreService();
  var uuid = Uuid();
  final _picker = ImagePicker();
  final storageService = FirebaseStorageService();

  //Get Data
  Stream<String> get name => _name.stream.transform(validateUserName);
  Stream<String> get lastName => _lastName.stream.transform(validateUserName);
  Stream<String> get age => _age.stream.transform(validateUserAge);
  Stream<String> get profession =>
      _profession.stream.transform(validateUserProfession);
  Stream<String> get school => _school.stream.transform(validateUserSchool);
  Stream<String> get target => _target.stream.transform(validateTarget);
  Stream<String> get instagram => _instagram.stream.transform(validateUserName);
  Stream<String> get facebook => _facebook.stream.transform(validateUserName);
  Stream<String> get twitter => _twitter.stream.transform(validateUserName);
  Stream<String> get newMail => _newMail.stream.transform(validateUserName);

  //Email and Password
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  //Fetch user
  Future<User> userID(String userId) => db.fetchUser(userId);
  Future<User> fetchUser(String productId) => db.fetchUser(productId);
  Stream<List<User>> fetchUserId(String userId) => db.fetchUserId(userId);

  //validation
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);
  Stream<bool> get isValidSave => CombineLatestStream.combine5(
      name,
      lastName,
      age,
      profession,
      school,
      (name, lastName, age, profession, school) => true);
  //User
  Stream<User> get user => _user.stream;
  Stream<String> get errorMessage => _errorMessage.stream;
  String get userId => _user.value.userId;
  //Photo
  Stream<String> get imageUrlPhoto => _imageUrlPhoto.stream;
  Stream<bool> get isUploading => _isUploading.stream;
  //Save
  Stream<bool> get userSaved => _userSaved.stream;
  Stream<bool> get userDelete => _userDelete.stream;

  //Set Data
  //User form data
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeLastName => _lastName.sink.add;
  Function(String) get changeAge => _age.sink.add;
  Function(String) get changeProfession => _profession.sink.add;
  Function(String) get changeSchool => _school.sink.add;
  Function(String) get changeTarget => _target.sink.add;
  Function(String) get changeInstagram => _instagram.sink.add;
  Function(String) get changeFacebook => _facebook.sink.add;
  Function(String) get changeTwitter => _twitter.sink.add;
  Function(String) get changeNewEmail => _newMail.sink.add;
  //Email and password
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  //photo
  Function(String) get changeImageUrl => _imageUrlPhoto.sink.add;
  //User
  Function(String) get changeUserId => _userIdEdit.sink.add;
  Function(User) get changeUser => _userEdit.sink.add;

  dispose() {
    _name.close();
    _lastName.close();
    _email.close();
    _age.close();
    _profession.close();
    _school.close();
    _target.close();
    _instagram.close();
    _facebook.close();
    _twitter.close();
    _newMail.close();
    _password.close();
    _errorMessage.close();
    _imageUrlPhoto.close();
    _isUploading.close();
    _userSaved.close();
    _userDelete.close();
    _user.close();
    _userEdit.close();
    _userIdEdit.close();
  }

  //Transformers
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (regExpEmail.hasMatch(email.trim())) {
        sink.add(email.trim());
      } else {
        sink.addError('Must Be Valid Email Address');
      }
    },
  );

  final validateTarget = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName != null) {
      if (userName.length >= 0 && userName.length <= 400) {
        sink.add(userName.trim());
      } else {
        if (userName.length < 0) {
          sink.addError('Bir');
        } else {
          sink.addError('400 Karakter Sınırı');
        }
      }
    }
  });

  final validateUserProfession = StreamTransformer<String, String>.fromHandlers(
      handleData: (profession, sink) {
    if (profession != null) {
      if (profession.length >= 3 && profession.length <= 30) {
        sink.add(profession.trim());
      } else {
        if (profession.length < 3) {
          sink.addError('3 Karakterden Az Olamaz');
        } else {
          sink.addError('30 Karakter Sınırı');
        }
      }
    }
  });

  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName != null) {
      if (userName.length >= 3 && userName.length <= 20) {
        sink.add(userName.trim());
      } else {
        if (userName.length < 3) {
          sink.addError('3 Karakterden Az Olamaz');
        } else {
          sink.addError('20 Karakter Sınırı');
        }
      }
    }
  });

  final validateUserSchool = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName != null) {
      if (userName.length >= 3 && userName.length <= 50) {
        sink.add(userName.trim());
      } else {
        if (userName.length < 3) {
          sink.addError('3 Karakterden Az Olamaz');
        } else {
          sink.addError('50 Karakter Sınırı');
        }
      }
    }
  });

  final validateUserAge = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName != null) {
      if (userName.length >= 2 && userName.length == 2) {
        sink.add(userName.trim());
      } else {
        if (userName.length < 2) {
          sink.addError('2 Karakterden Az Olamaz');
        } else {
          sink.addError('2 Karakter Girmelisin');
        }
      }
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 8) {
        sink.add(password.trim());
      } else {
        sink.addError('8 Character Minimum');
      }
    },
  );

  //Functions
  Future<void> saveUserData() async {
    var user = User(
      userId: (_user.value == null) ? uuid.v4() : _user.value.userId,
      name: _name.value.trim(),
      lastName: _lastName.value,
      age: _age.value,
      profession: _profession.value,
      school: _school.value,
      target: _target.value,
      instagram: _instagram.value,
      facebook: _facebook.value,
      twitter: _twitter.value,
      newEmail: _newMail.value,
      imageUrl: _imageUrlPhoto.value,
    );

    return db
        .setUser(user)
        .then((value) => _userSaved.sink.add(true))
        .catchError((error) => _userSaved.sink.add(false));
  }

  Future<void> deleteUserData() async {
    var user = User(
      userId: (_user.value == null) ? uuid.v4() : _user.value.userId,
      name: _name.value = null,
      lastName: _lastName.value = null,
      age: _age.value = null,
      profession: _profession.value = null,
      school: _school.value = null,
      target: _target.value = null,
      instagram: _instagram.value = null,
      facebook: _facebook.value = null,
      twitter: _twitter.value = null,
      newEmail: _newMail.value = null,
      imageUrl: _imageUrlPhoto.value = null,
    );

    return db
        .deleteUser(user)
        .then((value) => _userDelete.sink.add(true))
        .catchError((error) => _userDelete.sink.add(false));
  }

  pickImage() async {
    PickedFile image;
    File croppedFile;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Get Image From Device
      image = await _picker.getImage(source: ImageSource.gallery);

      //Upload to Firebase
      if (image != null) {
        _isUploading.sink.add(true);

        //Get Image Properties
        ImageProperties properties =
            await FlutterNativeImage.getImageProperties(image.path);

        //CropImage
        if (properties.height > properties.width) {
          var yoffset = (properties.height - properties.width) / 2;
          croppedFile = await FlutterNativeImage.cropImage(image.path, 0,
              yoffset.toInt(), properties.width, properties.width);
        } else if (properties.width > properties.height) {
          var xoffset = (properties.width - properties.height) / 2;
          croppedFile = await FlutterNativeImage.cropImage(image.path,
              xoffset.toInt(), 0, properties.height, properties.height);
        } else {
          croppedFile = File(image.path);
        }

        //Resize
        File compressedFile = await FlutterNativeImage.compressImage(
            croppedFile.path,
            quality: 100,
            targetHeight: 600,
            targetWidth: 600);

        var imageUrl =
            await storageService.uploadProductImage(compressedFile, uuid.v4());
        changeImageUrl(imageUrl);
        _isUploading.sink.add(false);
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  Future signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      if (_googleUser != null) {
        GoogleSignInAuthentication _googleAuth =
            await _googleUser.authentication;
        if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
          AuthResult authResult = await _auth.signInWithCredential(
            GoogleAuthProvider.getCredential(
              idToken: _googleAuth.idToken,
              accessToken: _googleAuth.accessToken,
            ),
          );

          var user =
              User(userId: authResult.user.uid, email: authResult.user.email);
          await db.addUser(user);
          _user.sink.add(user);
        }
      }
    } on PlatformException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    }
  }

  Future<bool> isLoggedIn() async {
    var firebaseUser = await _auth.currentUser();
    if (firebaseUser == null) return false;

    var user = await db.fetchUser(firebaseUser.uid);
    if (user == null) return false;

    _user.sink.add(user);
    return true;
  }

  logout() async {
    final _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
    await _auth.signOut();
    _user.sink.add(null);
  }

  clearErrorMessage() {
    _errorMessage.sink.add('');
  }
}
