import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/review.dart';

final reviewRepositoryProvider = Provider((ref) => ReviewRepository());

class ReviewRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 리뷰 저장
  Future<void> addReview(Review review) async {
    await _firestore.collection('reviews').doc(review.id).set(review.toJson());
  }

  // 특정 좌표의 모든 리뷰 불러오기
  Future<List<Review>> getReviews(String mapX, String mapY) async {
    final querySnapshot = await _firestore
        .collection('reviews')
        .where('mapX', isEqualTo: mapX)
        .where('mapY', isEqualTo: mapY)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Review.fromJson(doc.data()))
        .toList();
  }

  // 특정 장소(locationId)의 모든 리뷰를 실시간으로 불러오기
  Stream<List<Review>> getReviewsStream(String locationId) {
    return _firestore
        .collection('reviews')
        .where('locationId', isEqualTo: locationId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Review.fromJson(doc.data())).toList());
  }
}
