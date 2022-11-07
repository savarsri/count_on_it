import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabase {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('Profile');

  Future<void> createUserData(
      String uid, String name, String email, String profilePictureUrl) async {
    return await profileList.doc(uid).set({
      'uid': uid,
      'Name': name,
      'Email': email,
      'ProfilePictureUrl': profilePictureUrl,
    });
  }

  Future<String> getUserName() async {
    var collection = FirebaseFirestore.instance.collection('Profile');
    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    Map<String, dynamic> data = docSnapshot.data()!;
    String name = data['Name'];
    print(name);
    return name;
  }
}
