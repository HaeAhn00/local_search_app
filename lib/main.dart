import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/ui/pages/home/home_page.dart';

void main() {
  // ProviderScope 로 앱을 감싸서 RiverPod이 ViewModel 관리할 수 있게 선언
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // 앱의 전반적인 색상(AppBar 등)을 설정합니다.
        primarySwatch: Colors.blue,
        // Scaffold의 기본 배경색을 앱 전체에 적용합니다.
        scaffoldBackgroundColor: Colors.grey[100], // 연한 회색
      ),
      home: const HomePage(),
    );
  }
}
