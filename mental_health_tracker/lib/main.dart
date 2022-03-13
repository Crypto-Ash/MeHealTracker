import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_tracker/Services/user_preferences.dart';
import 'package:mental_health_tracker/app/routes/app.routes.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mental Health Tracker',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/splash",
      onGenerateRoute: AppRouter.generateRoute
    );
  }
}