import 'package:flutter/material.dart';
import 'package:flutter_project_3/view/detail_page/book_detail_page.dart';
import 'package:flutter_project_3/view/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false);
  }
}
