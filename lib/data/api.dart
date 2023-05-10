import 'dart:convert';
import '../model/Photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi{
  final baseUrl = 'https://pixabay.com/api/';
  final key = '36206009-fe028570b3c99a317c543088c';

  Future<List<Photo>> fetch(String querry) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?key=$key&q=$querry&image_type=photo'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}


