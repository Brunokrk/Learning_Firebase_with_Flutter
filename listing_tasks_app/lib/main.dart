import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:listing_tasks_app/_core/my_colors.dart';
import 'package:listing_tasks_app/authentication/screens/auth_screen.dart';
import 'package:listing_tasks_app/firestore/presentation/home_screen.dart';
import 'package:listing_tasks_app/storage/storage_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listin - Lista Colaborativa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        appBarTheme: const AppBarTheme(
          color: Colors.purple,
          toolbarHeight: 72,
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)))
        ),
      ),
      home:const RoteadorTelas(),
    );
  }
}

class RoteadorTelas extends StatelessWidget {
  const RoteadorTelas({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.userChanges(), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }else{
        if(snapshot.hasData){
          return HomeScreen(user: snapshot.data!);
        }else{
          return const AuthScreen();
        }
      }

    },);
  }
}
