import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:image_storage/data/api.dart';

import '../model/Photo.dart';

class PhotoProvider extends InheritedWidget { // InheritedWidget 객체에는 불변 객체만 넣을 수 (노란줄)
  final PixabayApi api;

  final _photoStreamController = StreamController<List<Photo>>()..add([]); // ..빈 리스트를 반환 (void를 반환하는 메서드)
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  PhotoProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  static PhotoProvider of(BuildContext context){
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PixabayApi fount in context'); // result가 null이면 메세지
    return result!;
  }

  Future<void> fetch(String querry) async {
    final result = await api.fetch(querry);
    _photoStreamController.add(result); // controller로 result가 들어가고 외부에서는 Stream을 통해서 변경사항을 컨트롤
  }
  @override
  // 변경이 되면 다시 전달
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
    // 이전 상태와 변경이 되었는지 check
  }
}
