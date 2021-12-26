import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college/enums/user_type_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
CollectionReference _userCollection = FirebaseFirestore.instance.collection('user');

class CustomUser {
  String? email, password;
  UserType? userType;
  Timestamp? createdAt, updatedAt;

  CustomUser({
    required this.email,
    required this.password,
    this.userType = UserType.user,
  });

  CustomUser.fromJson(Map<String, dynamic> user) {
    this.email = user['email'];
    this.password = user['password'];
    this.userType = getUserTypeByName(user['user_type']);
    this.createdAt = user['created_at'];
    this.updatedAt = user['updated_at'];
  }

  Map<String, dynamic> toMap() => {
        'email': this.email,
        'password': this.password,
        'user_type': getUserTypeName(this.userType as UserType),
        'created_at': this.createdAt,
        'updated_at': this.updatedAt,
      };

  static String? get currentUserEmail => _auth.currentUser?.email;

  static User? get currentUser => _auth.currentUser;

  Future add() async {
    this.createdAt = this.updatedAt = Timestamp.now();
    await _userCollection
        .add(this.toMap())
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add User: $error'));
  }

  static Future<CustomUser> getCurrentUser() async {
    final users = await _userCollection.where('email', isEqualTo: currentUserEmail).get();
    return CustomUser.fromJson(users.docs.first.data() as Map<String, dynamic>);
  }

  static Future signOut() async {
    await _auth.signOut();
  }
}
