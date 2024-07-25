import 'package:firebase_core/firebase_core.dart';
import 'package:partidos_politicos/pages/home_page.dart';
import 'package:partidos_politicos/pages/create_account_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAj4sR1c_sURjnNt6rlGeJ8zRuXqsWJ798",
        appId: "1:823358129569:android:004c42e9279d9574d3f7e0",
        messagingSenderId: "823358129569",
        projectId: "fir-app-926c5"),
  );
  runApp(
    MaterialApp(
      home: CreateAccountPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
