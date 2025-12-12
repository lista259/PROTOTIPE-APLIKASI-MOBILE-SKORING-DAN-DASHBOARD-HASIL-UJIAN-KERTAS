import 'package:flutter/material.dart';
import 'views/menu.dart'; // pastikan path sesuai folder kamu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OOTDY Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(), // 👈 langsung ke menu utama
      debugShowCheckedModeBanner: false,
    );
  }
}
