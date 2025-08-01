class Location {
  final String title;
  // Firestore 문서 ID로 사용될 고유 ID. 좌표값을 조합하여 생성합니다.
  String get id => '$mapx-$mapy';

  final String category;
  final String roadAddress;
  // Firebase에 리뷰를 저장하기 위해 좌표값도 모델에 포함합니다.
  final String mapx;
  final String mapy;

  Location({
    required this.title,
    required this.category,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  // API 응답(JSON)을 Location 객체로 변환하는 팩토리 생성자입니다.
  factory Location.fromJson(Map<String, dynamic> json) {
    // Naver API는 검색어에 <b> 태그를 포함하는 경우가 있어, 이를 제거합니다.
    final String rawTitle = json['title'] as String? ?? '';
    final String cleanTitle = rawTitle.replaceAll(RegExp(r'<[^>]*>'), '');

    return Location(
      title: cleanTitle,
      category: json['category'] as String? ?? '',
      roadAddress: json['roadAddress'] as String? ?? '',
      mapx: json['mapx'] as String? ?? '',
      mapy: json['mapy'] as String? ?? '',
    );
  }
}
