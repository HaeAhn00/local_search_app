import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/model/review.dart';
import 'package:local_search_app/data/repository/review_repository.dart';
import 'package:uuid/uuid.dart';

// ViewModel을 제공하는 Provider입니다.
final detailViewModelProvider = Provider.autoDispose((ref) {
  // ReviewRepository를 주입받습니다.
  final repository = ref.watch(reviewRepositoryProvider);
  return DetailViewModel(repository);
});

class DetailViewModel {
  final ReviewRepository _repository;

  DetailViewModel(this._repository);

  // 리뷰를 추가하는 비즈니스 로직을 담당합니다.
  Future<void> addReview({
    required String content,
    required Location location,
  }) async {
    final newReview = Review(
      id: const Uuid().v4(),
      locationId: location.id,
      content: content,
      mapX: location.mapx,
      mapY: location.mapy,
      createdAt: DateTime.now(),
    );
    // Repository를 통해 Firestore에 리뷰를 추가합니다.
    await _repository.addReview(newReview);
  }
}
