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
        // AppBar의 테마를 설정하여 앱 전체에 일관된 스타일을 적용합니다.
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100], // AppBar 배경색을 body와 통일
          elevation: 0, // AppBar와 body 사이의 그림자 제거
          foregroundColor: Colors.black, // AppBar의 아이콘과 텍스트 색상을 검은색으로 설정
        ),
      ),
      home: const HomePage(),
    );
  }
}
