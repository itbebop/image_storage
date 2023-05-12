import 'dart:convert';
import 'package:image_storage/data/photo_api_repository.dart';

import '../model/Photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi implements PhotoApiRepository{
  final baseUrl = 'https://pixabay.com/api/';
  final key = '36206009-fe028570b3c99a317c543088c';

  @override
  Future<List<Photo>> fetch(String querry) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?key=$key&q=$querry&image_type=photo'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}


