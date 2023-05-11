import 'dart:async';

import 'package:image_storage/data/api.dart';

import '../model/Photo.dart';

class HomeViewModel {
  final PixabayApi api;

  final _photoStreamController = StreamController<List<Photo>>()..add([]); // ..빈 리스트를 반환 (void를 반환하는 메서드)
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.api);

  Future<void> fetch(String querry) async {
    final result = await api.fetch(querry);
    _photoStreamController.add(result); // controller로 result가 들어가고 외부에서는 Stream을 통해서 변경사항을 컨트롤
  }
}