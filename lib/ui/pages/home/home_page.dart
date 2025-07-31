import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UI 개발을 위한 임시 데이터
  final List<Map<String, String>> _mockLocations = [
    {
      'title': '카카오프렌즈 홍대플래그십 스토어',
      'category': '생활,편의 > 캐릭터상품',
      'roadAddress': '서울 마포구 양화로 162',
    },
    {
      'title': '라인프렌즈 홍대플래그십 스토어',
      'category': '생활,편의 > 캐릭터상품',
      'roadAddress': '서울 마포구 양화로 141',
    },
  ];

  TextEditingController textEditingController = TextEditingController();

  void search(String text) {
    print("search");
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            maxLines: 1,
            controller: textEditingController,
            onSubmitted: search,
            decoration: InputDecoration(
              hintText: '검색어를 입력해 주세요',
              border: MaterialStateOutlineInputBorder.resolveWith(
                (states) {
                  if (states.contains(WidgetState.focused)) {
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    );
                  }
                  return OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                search(textEditingController.text);
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.search),
              ),
            ),
          ],
        ),
        // 2. Scaffold body 영역에 ListView 배치
        body: ListView.builder(
          itemCount: _mockLocations.length,
          itemBuilder: (context, index) {
            final location = _mockLocations[index];
            // ListView의 자녀 위젯 내 title, category, roadAddress 세로로 출력
            return ListTile(
              title: Text(location['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('분류: ${location['category']!}'),
                  Text('주소: ${location['roadAddress']!}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
