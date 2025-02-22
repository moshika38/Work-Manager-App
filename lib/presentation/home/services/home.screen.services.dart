import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserIfNotExists(String uid) async {
    final docRef = _firestore.collection('users').doc(uid);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      await docRef.set({});
    }
  }
}


