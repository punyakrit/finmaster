// ignore_for_file: unused_local_variable

import 'package:finmaster/Screen/Login/login.dart';
import 'package:finmaster/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';

import 'home/Home.dart';

class Onboarding extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: OnBoard(
          pageController: _pageController,
          // Either Provide onSkip Callback or skipButton Widget to handle skip state

          onBoardData: onBoardData,
          titleStyles: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 25,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.15,
          ),
          // ignore: prefer_const_constructors

          descriptionStyles: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          pageIndicatorStyle: const PageIndicatorStyle(
            width: 100,
            inactiveColor: Colors.white,
            activeColor: Colors.white,
            inactiveSize: Size(0, 0),
            activeSize: Size(0, 0),
          ),
          // Either Provide onSkip Callback or skipButton Widget to handle skip state

          skipButton: TextButton(
            onPressed: () {},
            child: const Text(""),
          ),
          // Either Provide onDone Callback or nextButton Widget to handle done state
          nextButton: OnBoardConsumer(
            builder: (context, ref, child) {
              final state = ref.watch(onBoardStateProvider);
              return InkWell(
                onTap: () {
                ap.isSignedIn == true?
              Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home())
                      )
                 : Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login())
                      );
                },
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
      title: "Getting started is easy",
      description: "Create your user and workspace name and you're in.",
      imgUrl: "assets/img2.jpg"),
];
