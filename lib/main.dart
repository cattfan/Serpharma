import 'package:flutter/material.dart';
import 'homepage.dart'; // Import tệp home_page.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serpharma',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Open Sans', // Bạn có thể chọn font chữ phù hợp
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}