import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String content;
  final String locationId; // 장소와 리뷰를 연결하기 위한 ID
  final String mapX;
  final String mapY;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.content,
    required this.locationId,
    required this.mapX,
    required this.mapY,
    required this.createdAt,
  });

  // Firestore로부터 데이터를 읽어올 때 사용
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      content: json['content'] as String,
      locationId: json['locationId'] as String,
      mapX: json['mapX'] as String,
      mapY: json['mapY'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  // Firestore에 데이터를 저장할 때 사용
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'mapX': mapX,
      'mapY': mapY,
      'locationId': locationId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
