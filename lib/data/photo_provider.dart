import 'package:flutter/cupertino.dart';

import '../ui/home_view_model.dart';

class PhotoProvider extends InheritedWidget { // InheritedWidget 객체에는 불변 객체만 넣을 수 (노란줄)
  final HomeViewModel viewModel;

  const PhotoProvider({
    Key? key,
    required this.viewModel,
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
    return true;
    // 이전 상태와 비교하여 변경이 되었는지 check
  }
}
