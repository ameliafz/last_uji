import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:last_uji/home.dart';
import 'package:last_uji/login.dart';
import 'package:last_uji/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firebase_Auth().AuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: snapshot.data != null ? Dashboard() : Loginpage(),
          );
        }
        return loading();
      },
    );
  }
}

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}