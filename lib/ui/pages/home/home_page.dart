import 'package:flutter/material.dart';
import 'package:local_search_app/ui/detail/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    // UI 개발을 위한 임시 데이터 (build 메서드 내부에 선언)
    final List<Map<String, String>> mockLocations = [
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
        body: ListView.builder(
          // 1. ListView 자체에 padding을 주어 목록 전체의 상하좌우 여백을 만듭니다.
          padding: const EdgeInsets.all(8.0),
          itemCount: mockLocations.length,
          itemBuilder: (context, index) {
            final location = mockLocations[index];
            // 2. 각 아이템을 GestureDetector로 감싸 탭 이벤트를 추가합니다.
            return GestureDetector(
              onTap: () {
                // 탭하면 DetailPage로 이동하고, 선택한 location 정보를 전달합니다.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(location: location)),
                );
              },
              child: Container(
                // 3. 아이템 사이에 하단 여백(margin)을 줍니다.
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(location['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('분류: ${location['category']!}'),
                      Text('주소: ${location['roadAddress']!}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
