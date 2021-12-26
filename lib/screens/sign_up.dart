import 'package:college/Models/custom_user.dart';
import 'package:college/enums/user_type_enum.dart';
import 'package:college/components/custom_buttons/rounded_button.dart';
import 'package:college/screens/login.dart';
import 'package:college/screens/home.dart';
import 'package:college/validation/validation_error.dart';
import 'package:college/validation/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  static const String id = 'sign_up';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email, password;
  bool _showSpinner = false;
  bool _showEmailError = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signUp() async {
    setState(() {
      _showSpinner = true;
      _showEmailError = false;
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
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // =========== in success ==============
        if (userCredential.credential == null) {
          CustomUser user = CustomUser(email: email, password: password, userType: UserType.user);
          await user.add();
          Navigator.pushReplacementNamed(context, Home.id);
        }
        // =====================================
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            _showSpinner = false;
            _showEmailError = true;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w900))),
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
                    ValidationError(errorMessage: 'Email already exists!', visible: _showEmailError),
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
                      validator: (password) => Validator.passwordValidator(password),
                      onSaved: (value) => password = value,
                    ),
                    SizedBox(height: 40),
                    RoundedButton(
                      title: 'Sign Up',
                      colour: Colors.blueAccent,
                      onPressed: signUp,
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '),
                        InkWell(
                          onTap: () => Navigator.pushReplacementNamed(context, Login.id),
                          child: Text(
                            'Login here',
                            style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
