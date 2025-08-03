#  local_search_app

##  프로젝트 소개
'**local_search_app**'은 Flutter 기반의 **장소 검색 및 리뷰 애플리케이션**입니다.  
MVVM(Model-View-ViewModel) 디자인 패턴을 기반으로 체계적인 코드 구조와 효율적인 상태 관리를 지향합니다.

---

##  주요 기능

- **장소 검색**  
  Naver Local Search API를 사용하여 사용자가 원하는 장소를 검색하고, 장소 이름, 분류, 주소 등 상세 정보를 제공합니다.

- **실시간 리뷰**  
  Firebase Firestore를 백엔드로 사용하여 장소별 리뷰를 실시간으로 불러오고 작성할 수 있습니다.

- **상태 관리**  
  Riverpod 패키지를 사용해 로딩 상태, 오류 처리, 검색 결과 등의 앱 상태를 효율적으로 관리합니다.

---

## 사용 기술
- `Dart`
- `Flutter`

---

## 실행 화면

<div style="display: flex; gap: 10px;">
  <img src="assets/images/test1.png" alt="screen 1" style="width: 48%;">
  <img src="assets/images/test2.png" alt="screen 2" style="width: 48%;">
</div>

---

### 주요 패키지 (Dependencies)
| 패키지명           | 설명                                 |
|--------------------|--------------------------------------|
| `flutter_riverpod` | 상태 관리                           |
| `firebase_core`    | Firebase 연동                        |
| `cloud_firestore`  | Firestore 데이터베이스               |
| `dio`              | HTTP 통신 (Naver API 호출용)        |
| `uuid`             | 고유 ID 생성                        |
| `intl`             | 날짜 및 시간 포맷 처리              |

---

##  외부 API 및 서비스

- **Naver Local Search API**  
  장소 검색 기능 제공

- **Firebase Firestore**  
  리뷰 데이터 저장 및 실시간 동기화  

---

##  프로젝트 구조 (MVVM 기반)

```plaintext
lib/
├── data/              # 데이터 및 비즈니스 로직 계층
│   ├── model/         # 데이터 모델 (Location, Review 등)
│   └── repository/    # 외부 API 및 데이터 소스 통신 로직
│       ├── location_repository.dart
│       └── review_repository.dart
│
├── ui/                # 사용자 인터페이스 계층
│   ├── pages/         # 화면별 위젯 (HomePage, DetailPage 등)
│   └── viewmodels/    # ViewModel: UI 상태 및 로직 관리
│
├── main.dart          # 앱 진입점 및 전역 ProviderScope, 테마 설정 
```

