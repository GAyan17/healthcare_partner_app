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
          print(firebaseUser.toString());
          var documentSnapshot = await _firestore
              .collection(_partnerCollection)
              .doc(firebaseUser.uid)
              .get();
          _user = User.fromJson(documentSnapshot.data()!);
          print(_user.toString());
          return _user;
        }
        _user = User.nouser;
        print(_user.toString());
        return _user;
      });

  User get currentUser => _user;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String organization,
    required bool provideEmergencyServices,
    required String serviceTimeStart,
    required String serviceTimeEnd,
    required String serviceDays,
    required List<String> serviceTypes,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var firebaseUser = _firebaseAuth.currentUser!;
      var newUser = User(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        name: name,
        organization: organization,
        provideEmergencyServices: provideEmergencyServices,
        serviceTimeStart: serviceTimeStart,
        serviceTimeEnd: serviceTimeEnd,
        serviceDays: serviceDays,
        serviceTypes: serviceTypes,
        avgRating: 0.0,
        oneStarRatings: 0,
        twoStarRatings: 0,
        threeStarRatings: 0,
        fourStarRatings: 0,
        fiveStarRatings: 0,
      );
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
