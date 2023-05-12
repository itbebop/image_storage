import 'package:image_storage/model/Photo.dart';

abstract class PhotoApiRepository {
  Future<List<Photo>> fetch(String query);
}