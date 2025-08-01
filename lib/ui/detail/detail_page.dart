import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/model/review.dart';
import 'package:local_search_app/data/repository/review_repository.dart';
import 'package:intl/intl.dart';
import 'package:local_search_app/ui/detail/detail_view_model.dart';

// 특정 locationId에 해당하는 리뷰 목록을 실시간으로 가져오는 StreamProvider입니다.
final reviewsStreamProvider =
    StreamProvider.autoDispose.family<List<Review>, String>((ref, locationId) {
  return ref.watch(reviewRepositoryProvider).getReviewsStream(locationId);
});

class DetailPage extends ConsumerStatefulWidget {
  // HomePage에서 전달받은 위치 정보를 저장할 변수입니다.
  final Location location;

  // 생성자를 통해 location 데이터를 필수로 받도록 합니다.
  const DetailPage({super.key, required this.location});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewsAsyncValue =
        ref.watch(reviewsStreamProvider(widget.location.id));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // AppBar의 제목을 전달받은 위치의 이름으로 설정합니다.
          title: Text(widget.location.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildLocationInfo(),
              const SizedBox(height: 24),
              _buildReviewInput(),
              const SizedBox(height: 16),
              const Divider(),
              const Text('리뷰 목록',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Expanded(
                child: reviewsAsyncValue.when(
                  data: (reviews) => _buildReviewsList(reviews),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) =>
                      Center(child: Text('리뷰를 불러오는데 실패했습니다: $err')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildLocationInfo() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         widget.location.title,
  //         style: Theme.of(context)
  //             .textTheme
  //             .headlineSmall
  //             ?.copyWith(fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 16),
  //       Text('분류: ${widget.location.category}',
  //           style: Theme.of(context).textTheme.titleMedium),
  //       const SizedBox(height: 8),
  //       Text('주소: ${widget.location.roadAddress}',
  //           style: Theme.of(context).textTheme.titleMedium),
  //     ],
  //   );
  // }

  Widget _buildReviewInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _reviewController,
            decoration: const InputDecoration(
              hintText: '리뷰를 남겨주세요.',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _submitReview,
          child: const Text('등록'),
        ),
      ],
    );
  }

  void _submitReview() async {
    final comment = _reviewController.text.trim();
    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('리뷰 내용을 입력해주세요.')),
      );
      return;
    }

    try {
      // ViewModel의 addReview 메서드를 호출하여 비즈니스 로직을 위임합니다.
      await ref.read(detailViewModelProvider).addReview(
            content: comment,
            location: widget.location,
          );

      _reviewController.clear();
      FocusScope.of(context).unfocus();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('리뷰 등록에 실패했습니다: $e')),
      );
    }
  }

  Widget _buildReviewsList(List<Review> reviews) {
    if (reviews.isEmpty) {
      return const Center(child: Text('아직 등록된 리뷰가 없습니다.'));
    }

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        // createdAt 필드를 사용하여 날짜 포맷을 지정합니다.
        final formattedDate =
            DateFormat('yyyy-MM-dd HH:mm').format(review.createdAt);

        return Card(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: Text(review.content),
            subtitle: Text(formattedDate),
          ),
        );
      },
    );
  }
}
