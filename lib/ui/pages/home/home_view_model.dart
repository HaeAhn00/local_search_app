import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/repository/location_repository.dart';

// 1. UI의 상태를 정의하는 클래스 (State)
// 로딩 상태, 검색 결과, 에러 메시지 등을 담습니다.
// 불변(immutable) 객체로 만들어 상태 관리의 안정성을 높입니다.
class HomeState {
  final bool isLoading;
  final List<Location> locations;
  final String? errorMessage;

  HomeState({
    this.isLoading = false,
    this.locations = const [],
    this.errorMessage,
  });

  // 상태를 복사하여 일부 값만 변경하는 메서드. 예: state.copyWith(isLoading: true)
  HomeState copyWith({
    bool? isLoading,
    List<Location>? locations,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      locations: locations ?? this.locations,
      errorMessage: errorMessage, // null로도 덮어쓸 수 있도록 ?? 제거
    );
  }
}

// 2. ViewModel: UI의 상태(HomeState)를 관리하고 비즈니스 로직(검색)을 처리합니다.
class HomeViewModel extends StateNotifier<HomeState> {
  final LocationRepository _repository;

  HomeViewModel(this._repository) : super(HomeState());

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final locations = await _repository.searchLocations(query);
      state = state.copyWith(isLoading: false, locations: locations);
    } on DioException catch (e) {
      String errorMessage = '네트워크 오류가 발생했습니다. 인터넷 연결을 확인해주세요.';
      if (e.response?.statusCode == 401) {
        errorMessage = 'API 인증에 실패했습니다. API 키를 확인해주세요.';
      }
      state = state.copyWith(isLoading: false, errorMessage: errorMessage);
    } catch (e) {
      state =
          state.copyWith(isLoading: false, errorMessage: '알 수 없는 오류가 발생했습니다.');
    }
  }
}

// 3. Provider: ViewModel을 생성하고 UI에 제공합니다.
final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final repository = ref.watch(locationRepositoryProvider);
  return HomeViewModel(repository);
});
