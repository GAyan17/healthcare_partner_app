import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'exceptions.dart';
import 'models/user.dart';

class AuthRepository {
  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  late final User _user;

  static const _partnerCollection = 'partners';

  Stream<User> get user =>
      _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
        if (firebaseUser != null) {
          var documentSnapshot = await _firestore
              .collection(_partnerCollection)
              .doc(firebaseUser.uid)
              .get();
          _user = User.fromJson(documentSnapshot.data()!);
          return _user;
        }
        _user = User.nouser;
        return _user;
      });

  User get currentUser => _user;

  Future<void> signUp(
      {required String email,
      required String password,
      required String name,
      required DateTime dob,
      required String organization}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var firebaseUser = _firebaseAuth.currentUser!;
      var newUser = User(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          name: name,
          dob: dob,
          organization: organization);
      await _firestore
          .collection(_partnerCollection)
          .doc(firebaseUser.uid)
          .set(newUser.toJson());
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}
