import 'package:finmaster/Screen/splash.dart';
import 'package:finmaster/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';


import 'firebase_options.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider())
    ],
      child: MaterialApp(
        navigatorKey: navigatorkey,
        title: 'FinMaster',
        theme: ThemeData(),
        home: SplashScreen(),
      ),
    );
  }
}
