import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseStorageService {
  final storage = FirebaseStorage.instance;
  StorageReference _storageReference;

  Future<String> uploadFile(
      String userId, String fileType, File yuklenecekDosya) async {
    _storageReference = storage.ref().child(userId).child(fileType);
    var uploadTask = _storageReference.putFile(yuklenecekDosya);

    var url = (await uploadTask.onComplete).ref.getDownloadURL();
    return url;
  }

  Future<String> uploadProductImage(File file, String fileName) async {
    var snapshot = await storage
        .ref()
        .child('usersImages/$fileName')
        .putFile(file)
        .onComplete;

    return await snapshot.ref.getDownloadURL();
  }
}
