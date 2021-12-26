import 'package:college/Models/custom_user.dart';
import 'package:college/enums/user_type_enum.dart';
import 'package:college/screens/add_schedule.dart';
import 'package:college/screens/admin_home.dart';
import 'package:college/screens/hall_schedule.dart';
import 'package:college/screens/hall_direction.dart';
import 'package:college/screens/login.dart';
import 'package:college/screens/home.dart';
import 'package:college/screens/search_result.dart';
import 'package:college/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ============================================================
  UserType userType = UserType.user;
  bool isLogin = CustomUser.currentUser != null;
  // await CustomUser.signOut();
  if (isLogin) {
    CustomUser user = await CustomUser.getCurrentUser();
    userType = user.userType as UserType;
  }
  // ============================================================
  runApp(MyApp(isLogin: isLogin, userType: userType));
}

class MyApp extends StatelessWidget {
  MyApp({required this.isLogin, required this.userType});
  final bool isLogin;
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: AdminHome.id,
      initialRoute: isLogin
          ? userType == UserType.user
              ? Home.id
              : AdminHome.id
          : Login.id,
      routes: {
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        Home.id: (context) => Home(),
        SearchResult.id: (context) => SearchResult(),
        HallDirection.id: (context) => HallDirection(),
        HallSchedule.id: (context) => HallSchedule(),
        AdminHome.id: (context) => AdminHome(),
        AddSchedule.id: (context) => AddSchedule(),
      },
    );
  }
}
