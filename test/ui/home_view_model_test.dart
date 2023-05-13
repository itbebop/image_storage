import 'package:flutter_test/flutter_test.dart';
import 'package:image_storage/data/photo_api_repository.dart';
import 'package:image_storage/data/pixabay_api.dart';
import 'package:image_storage/model/photo.dart';
import 'package:image_storage/ui/home_view_model.dart';

void main() {
  test('Stream이 잘 동작해야 한다.', () async {
    final viewModel = HomeViewModel(FakePhotoApiRepository());
    // HomeScreen 안에 있었으면 따로 객체생성해서 테스트 할 수 없었음
    // test를 위해 View 등 따로 분리하는 것
    // PixabayApi에 의존하고 있어 PixabayApi에 문제가 있을 경우에는 Test 불가
    // 따라서 PixabayApi 의존하지 않게 바꿔서 테스트 할 것
    // Pixabay 안에서 필요한 기능은 fetch임
    await viewModel.fetch("apple");
    await viewModel.fetch("cat");

    final result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(
      // pub.dev에 test 방법 중 하나
      viewModel.photoStream,
      emitsInOrder([
        // 실제 데이터가 들어왔는지 볼 것
        equals([]),
        equals(result), // Photo 타입의 데이터가 들어왔는지 검사
        equals(result), // 두번 들어왔는지 확인
      ]),
    );
    // pub.dev에 test 라이브러리 읽어볼 것.
    // Stream Matchers
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<List<Photo>> fetch(String query) async {
    Future.delayed(const Duration(milliseconds: 500));
    return fakeJson.map((e) => Photo.fromJson(e)).toList();
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 736877,
    "pageURL":
        "https://pixabay.com/photos/tree-cat-silhouette-moon-full-moon-736877/",
    "type": "photo",
    "tags": "tree, cat, silhouette",
    "previewURL":
        "https://cdn.pixabay.com/photo/2015/04/23/21/59/tree-736877_150.jpg",
    "previewWidth": 150,
    "previewHeight": 100,
    "webformatURL":
        "https://pixabay.com/get/g98beff7b4d7b2b39547ddcd9c203979cb181772bd6850ba34f2da89fecc2b5048fb8589da12c8f9a643794fb2a201fec_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 427,
    "largeImageURL":
        "https://pixabay.com/get/g2539581f19e019ba0d6bd5fe546c80c718cb88230c32d21e067f16e6f7e38dc75014eba626131e223d251de9e666ce91dbe631a4ca3f5e7f7151ef62ebfbae35_1280.jpg",
    "imageWidth": 1920,
    "imageHeight": 1282,
    "imageSize": 97150,
    "views": 1281876,
    "downloads": 657388,
    "collections": 2386,
    "likes": 2881,
    "comments": 584,
    "user_id": 909086,
    "user": "Bessi",
    "userImageURL":
        "https://cdn.pixabay.com/user/2019/04/11/22-45-05-994_250x250.jpg"
  },
  {
    "id": 2083492,
    "pageURL":
        "https://pixabay.com/photos/cat-young-animal-kitten-gray-cat-2083492/",
    "type": "photo",
    "tags": "cat, young animal, kitten",
    "previewURL":
        "https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_150.jpg",
    "previewWidth": 150,
    "previewHeight": 91,
    "webformatURL":
        "https://pixabay.com/get/gba9e92a859889828f177bf991b7044b446fc71ff58e972e8e5416b78713677bec3b1d0209dc74070185f5915081f1ccf14c1bab1bfa8ff512286c4f4dab20a8d_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 390,
    "largeImageURL":
        "https://pixabay.com/get/gb327f41061d4348cf23b0544c7ac513211b1621696b7e243c5d8de34221362df2691a05290b59287859bbe133adacfcdf77f557418bf0373b75602e96a6849c5_1280.jpg",
    "imageWidth": 4928,
    "imageHeight": 3008,
    "imageSize": 4130948,
    "views": 1240098,
    "downloads": 727144,
    "collections": 2128,
    "likes": 2374,
    "comments": 384,
    "user_id": 1777190,
    "user": "susannp4",
    "userImageURL":
        "https://cdn.pixabay.com/user/2015/12/16/17-56-55-832_250x250.jpg"
  },
];
