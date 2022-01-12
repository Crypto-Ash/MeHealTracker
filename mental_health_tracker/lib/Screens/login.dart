import 'dart:async';

import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health_tracker/Constants/colors.dart';
import 'package:mental_health_tracker/app/routes/app.routes.dart';
import 'package:mental_health_tracker/widgets/custom_button.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // Firebase
  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // regular expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      style: TextStyle(color: Color(authtxt)),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        hintStyle: TextStyle(
            color: Color(authtxt), fontFamily: 'Farro', fontSize: 16.0),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(12.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      style: TextStyle(color: Color(authtxt)),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        hintStyle: TextStyle(
            color: Color(authtxt), fontFamily: 'Farro', fontSize: 16.0),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(12.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(authbg),
      body: Column(
        children: <Widget>[
          if (!isKeyboard)
            Padding(
                padding: const EdgeInsets.all(55.0),
                child: Image.asset('assets/images/logintop.png',
                    height: 150, width: 300)),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
              color: Color(authtxt),
              fontFamily: 'Farro',
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 9.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style:
                          TextStyle(color: Color(authtxt), fontFamily: 'Farro'),
                    ),
                    emailField,
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Password',
                      style:
                          TextStyle(color: Color(authtxt), fontFamily: 'Farro'),
                    ),
                    passwordField,
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(22.0, 1.0, 20.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Forgot password?',
                    style: TextStyle(
                        color: Color(authtxt),
                        fontFamily: 'Farro',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800)),
                CustomButton(
                    buttonText: 'Login',
                    onPressed: () {
                      signIn(emailController.text, passwordController.text);
                    },
                    height: 62.0,
                    width: 140.0)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    elevation: 5.0,
                    height: 60.0,
                    minWidth: 60.0,
                    child: Image.asset(
                      'assets/images/google.png',
                      scale: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    onPressed: () {}),
                MaterialButton(
                    elevation: 5.0,
                    height: 60.0,
                    minWidth: 60.0,
                    child: Image.asset(
                      'assets/images/facebook.png',
                      scale: 10.0,
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {}),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Here?',
                        style: TextStyle(
                            color: Color(authtxt),
                            fontFamily: 'Farro',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w200)),
                    GestureDetector(
                      onTap: () {
                        Timer(const Duration(seconds: 2),
                            () => Navigator.pushNamed(context, '/signup'));
                      },
                      child: Text('Register',
                          style: TextStyle(
                              color: Color(authtxt),
                              fontFamily: 'Farro',
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  WriteCache.setString(key: "cache", value: email),
                  Navigator.of(context).pushReplacementNamed('/dashboard'),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appear to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          default:
            errorMessage = "Error occured please try later.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }
}
