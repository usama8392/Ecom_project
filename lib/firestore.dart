import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new user with a specific ID
  Future<void> addUser(String userId, Map<String, dynamic> userData) async {
    await _db.collection("users").doc(userId).set(userData).then(
          (value) => print('Document with ID $userId added successfully!'),
        );
  }

  // Retrieve all users
  Future<void> getAllUsers() async {
    await _db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  getUserType(String uid) {}
}
