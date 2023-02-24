import 'package:email_validator/email_validator.dart';
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:finmaster/Screen/Login/forgot.dart';
import 'package:finmaster/Screen/Login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class Login extends StatefulWidget {
  // final VoidCallback onClickedSignUp;

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  List<String> _texts = [
    "Hello",
    "Namaste",
    "Hola",
    "Bonjour",
    "Hallo",
    "Ciao",
    "Salve"
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _updateText();
  }

  void _updateText() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _index = (_index + 1) % _texts.length;
    });
    _updateText();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // SizedBox(height: 65),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _texts[_index],
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                  Text(
                    'Sign into your Account',
                    style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
                  ),
                  SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                              color: Colors.black12)
                        ]),
                    child: TextFormField(
                      cursorColor: Colors.purple,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? '          Enter a valid email'
                              : null,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0))),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 7,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                              color: Colors.black12)
                        ]),
                    child: TextFormField(
                      cursorColor: Colors.purple,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? '          Enter min 6 characters'
                          : null,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.deepPurple,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0))),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      GestureDetector(
                        child: Text(
                          'Forgot your Password?',
                          style: TextStyle(fontSize: 15, color: Colors.purple),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPass()));
                        },
                      ),
                    ],
                  ),
                ]),
          ),
          SizedBox(height: 40),
          Container(
            width: 230,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
              ),
            ),
            child: MaterialButton(
              minWidth: 230,
              height: 60,
              onPressed: signin,
              child: Text(
                "Login",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          ),
          SizedBox(height: w * 0.13),
          RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(fontSize: 17, color: Colors.purple.shade300),
                  children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(() => SignUp()),
                  text: " Create Account",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
              ])),
        ]),
      ),
    );
  }

  Future signin() async {
    // final isValid = formKey.currentState!.validate();
    // if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // ignore: use_build_context_synchronously
      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.success,
        title: "Login Successful",
        message: "",
        duration: 4,
      );
    } on FirebaseAuthException catch (e) {
      // var snackbar = Get.snackbar("Error", "Something went Wrong. Try again",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.orangeAccent.withOpacity(0.5));

      FancySnackbar.showSnackbar(
        context,
        snackBarType: FancySnackBarType.error,
        title: "Error",
        message: "Something went Wrong. Try again",
        duration: 4,
      );
      print(e);
    }
    Navigator.of(context).pop();
  }
}
