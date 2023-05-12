import 'dart:convert';
import 'package:image_storage/data/photo_api_repository.dart';

import '../model/Photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi implements PhotoApiRepository{
  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '36206009-fe028570b3c99a317c543088c';

  @override
  Future<List<Photo>> fetch(String querry, {http.Client? client}) async {
    client ??= http.Client(); // client가 null일 떄는 초기화를 하겠다는 것

    final response = await http.get(Uri.parse(
        '$baseUrl?key=$key&q=$querry&image_type=photo'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}


