import 'package:flutter/material.dart';
import 'package:flutter_project_3/view/detail_page/book_detail_page.dart';
import 'package:flutter_project_3/view/home_page/home_page.dart';

void main() {
  // path_provider 처럼 저장소 접근 라이브러리는 플러터 엔진 초기화 이후에만 동작함
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
