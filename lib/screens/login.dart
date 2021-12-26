import 'package:college/Models/custom_user.dart';
import 'package:college/enums/user_type_enum.dart';
import 'package:college/components/custom_buttons/rounded_button.dart';
import 'package:college/screens/admin_home.dart';
import 'package:college/screens/home.dart';
import 'package:college/screens/sign_up.dart';
import 'package:college/validation/validation_error.dart';
import 'package:college/validation/validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var email, password;
  bool _showSpinner = false;
  bool _showEmailError = false;
  bool _showPasswordError = false;

  void login() async {
    setState(() {
      _showSpinner = true;
      _showEmailError = false;
      _showPasswordError = false;
    });
    // ==========================================================
    var formData = _formKey.currentState;
    if (!formData!.validate()) {
      setState(() {
        _showSpinner = false;
      });
    } else {
      formData.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // ============== if there is no errors ==============
        if (userCredential.credential == null) {
          var user = await CustomUser.getCurrentUser();
          Navigator.pushReplacementNamed(context, user.userType == UserType.admin ? AdminHome.id : Home.id);
        }
      } on FirebaseAuthException catch (e) {
        // ============== if there is an error ===============
        setState(() {
          _showSpinner = false;
        });
        if (e.code == 'user-not-found') {
          // no user found for that email.
          setState(() {
            _showEmailError = true;
          });
        } else if (e.code == 'wrong-password') {
          // wrong password provided for that user.
          setState(() {
            _showPasswordError = true;
          });
        } else {
          print(e.code);
          setState(() {
            _showEmailError = true;
            _showPasswordError = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Login", style: TextStyle(fontWeight: FontWeight.w900))),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Image(image: AssetImage('images/college.jpg'), height: 180),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter email",
                      labelText: "Email",
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    ),
                    validator: (email) => Validator.emailValidator(email),
                    onSaved: (value) => email = value,
                  ),
                  ValidationError(errorMessage: 'Email is not found.', visible: _showEmailError),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter password",
                      labelText: "Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    ),
                    validator: (password) => Validator.passwordLoginValidator(password),
                    onSaved: (value) => password = value,
                  ),
                  ValidationError(errorMessage: 'Incorrect password.', visible: _showPasswordError),
                  SizedBox(height: 40),
                  RoundedButton(
                    title: 'Login',
                    colour: Colors.teal,
                    onPressed: login,
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? '),
                      InkWell(
                        onTap: () => Navigator.pushReplacementNamed(context, SignUp.id),
                        child: Text(
                          'Sign up here',
                          style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
