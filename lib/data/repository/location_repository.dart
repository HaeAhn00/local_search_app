import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';

// Repository를 제공하는 Provider입니다. ViewModel에서 이 Provider를 통해 Repository 인스턴스를 얻습니다.
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  // Dio 패키지를 사용하여 HTTP 통신을 수행합니다.
  return LocationRepository(dio: Dio());
});

class LocationRepository {
  final Dio _dio;

  LocationRepository({required Dio dio}) : _dio = dio;

  Future<List<Location>> searchLocations(String query) async {
    const String apiUrl = 'https://openapi.naver.com/v1/search/local.json';

    const String clientId = '0VvHHAej5IjvGWxW5aBC';
    const String clientSecret = 'u0CcZh3Jgi';

    try {
      final response = await _dio.get(
        apiUrl,
        queryParameters: {'query': query, 'display': 5},
        options: Options(
          headers: {
            'X-Naver-Client-Id': clientId,
            'X-Naver-Client-Secret': clientSecret,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> items = response.data['items'];
        return items.map((item) => Location.fromJson(item)).toList();
      } else {
        throw Exception('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      // ViewModel에서 예외를 처리할 수 있도록 다시 던집니다.
      rethrow;
    }
  }
}
