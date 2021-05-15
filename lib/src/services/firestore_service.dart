import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_firebase/src/models/user.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> addUser(User user) {
    return _db.collection('users').document(user.userId).setData(user.toMap());
  }

  Future<List<User>> getAllUser() async {
    QuerySnapshot querySnapshot = await _db.collection("users").getDocuments();
    List<User> tumKullanicilar = [];
    for (DocumentSnapshot tekUser in querySnapshot.documents) {
      User _tekUser = User.fromFirestore(tekUser.data);
      tumKullanicilar.add(_tekUser);
    }

    return tumKullanicilar;
  }

  Future<User> fetchUser(String userId) {
    return _db
        .collection('users')
        .document(userId)
        .get()
        .then((snapshot) => User.fromFirestore(snapshot.data));
  }

  Future<void> setUser(User user) {
    return _db.collection('users').document(user.userId).setData(user.toMap());
  }

  Future<void> deleteUser(User user) {
    return _db.collection('users').document(user.userId).setData(user.toMap());
  }

  Stream<List<User>> fetchUserId(String userId) {
    return _db
        .collection('users')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((query) => query.documents)
        .map((snapshot) => snapshot
            .map((document) => User.fromFirestore(document.data))
            .toList());
  }
}
