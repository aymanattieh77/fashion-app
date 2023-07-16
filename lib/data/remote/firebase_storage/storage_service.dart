import 'dart:io';

import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageService {
  Future<String> uploadAnImage(File file);
}

class StorageServiceImpl implements StorageService {
  final storage = FirebaseStorage.instance;

  @override
  Future<String> uploadAnImage(File file) async {
    try {
      Reference storageReference = storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch.toString()}');
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      throw FireException(message: e.message ?? e.toString());
    }
  }
}
