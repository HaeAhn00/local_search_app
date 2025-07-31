import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  // HomePage에서 전달받은 위치 정보를 저장할 변수입니다.
  final Map<String, String> location;

  // 생성자를 통해 location 데이터를 필수로 받도록 합니다.
  const DetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar의 제목을 전달받은 위치의 이름으로 설정합니다.
        title: Text(location['title'] ?? '상세 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location['title']!,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('분류: ${location['category']!}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('주소: ${location['roadAddress']!}',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
