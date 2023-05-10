import 'package:flutter/cupertino.dart';
import 'package:image_storage/data/api.dart';

class PhotoProvider extends InheritedWidget {
  final PixabayApi api;

  const PhotoProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  static PhotoProvider of(BuildContext context){
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PixabayApi fount in context'); // result가 null이면 메세지
    return result!;
  }
  @override
  // 변경이 되면 다시 전달
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
    // 이전 상태와 변경이 되었는지 check
  }
}
