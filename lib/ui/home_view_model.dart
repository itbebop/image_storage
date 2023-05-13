import 'dart:async';

import 'package:image_storage/data/photo_api_repository.dart';
import '../model/photo.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  final _photoStreamController = StreamController<List<Photo>>()
    ..add([]); // ..빈 리스트를 반환 (void를 반환하는 메서드)
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String querry) async {
    final result = await repository.fetch(querry);
    _photoStreamController
        .add(result); // controller로 result가 들어가고 외부에서는 Stream을 통해서 변경사항을 컨트롤
  }
}
