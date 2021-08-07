import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/models/user.dart';

class DatabaseService {
  final String uid;
  late String hid;
  DatabaseService({this.uid = ''});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference houseCollection =
      FirebaseFirestore.instance.collection('houses');

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<void> updateUserData(
      String name, String email, int phone, String address) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    });
  }

  Future addToCart({required hid}) {
    return userCollection
        .doc(getUserId())
        .collection("Cart")
        .doc(hid)
        .set({'hid': hid});
  }

  Future removeFromCart({required hid}) {
    return userCollection.doc(getUserId()).collection("Cart").doc(hid).delete();
  }

  Future addToFav({required hid}) {
    return userCollection
        .doc(getUserId())
        .collection("Favourites")
        .doc(hid)
        .set({'hid': hid});
  }

  Future removeFromFav({required hid}) {
    return userCollection
        .doc(getUserId())
        .collection("Favourites")
        .doc(hid)
        .delete();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        address: snapshot['address']);
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
