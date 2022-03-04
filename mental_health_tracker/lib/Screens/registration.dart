import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health_tracker/Constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_health_tracker/models/user_model.dart';
import 'package:mental_health_tracker/widgets/custom_button.dart';

class MySignup extends StatefulWidget {
  const MySignup({Key? key}) : super(key: key);

  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // Firebase auth
  final _auth = FirebaseAuth.instance;

  // error message
  String? errorMessage;

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
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

    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Color(authtxt)),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Enter name',
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

    final contactField = TextFormField(
      autofocus: false,
      controller: contactController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        contactController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Color(authtxt)),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.account_box_rounded,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Contact number',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // width: 400.0,
              height: 350.0,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 5.0,
                    left: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          elevation: 5.0,
                          height: 60.0,
                          minWidth: 60.0,
                          child: Icon(Icons.arrow_back_rounded),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          onPressed: () {}),
                    ),
                  ),
                  Positioned(
                      bottom: 20.0,
                      child: Image.asset('assets/images/RegistrationLogo.png',
                          height: 250, width: 350)),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Register',
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
                            'Name',
                            style: TextStyle(
                                color: Color(authtxt), fontFamily: 'Farro'),
                          ),
                          nameField,
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'E-mail',
                            style: TextStyle(
                                color: Color(authtxt), fontFamily: 'Farro'),
                          ),
                          emailField,
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Contact',
                            style: TextStyle(
                                color: Color(authtxt), fontFamily: 'Farro'),
                          ),
                          contactField,
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                                color: Color(authtxt), fontFamily: 'Farro'),
                          ),
                          passwordField,
                          SizedBox(
                            height: 19.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(buttonText: 'SignUp', onPressed: (){signUp(emailController.text, passwordController.text);}, height: 62.0, width: 140.0)
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {postDetailsToFirestore();WriteCache.setString(key: "cache", value: email);})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      }  on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        await Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email =  user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;
    userModel.contact = contactController.text;
    userModel.today = "N/A";
    userModel.questionans = "0";
    userModel.questionIndex = 1;
    userModel.score = 0;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushReplacementNamed(context, '/dashboard');
  }
}
