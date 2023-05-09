import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_storage/ui/widget/photo_widget.dart';

import '../model/Photo.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final List<Photo> photos = [];

  Future<List<Photo>> fetch(String querry) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=36206009-fe028570b3c99a317c543088c&q=$querry&image_type=photo'));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "이미지 검색 앱",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        // const는 변수 사용안하고 위젯사용하여 메모리를 아껴줌
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(
                  16.0), // GridView는 padding 속성 갖고 있어서 직접 줌
              //shrinkWrap: true,
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return PhotoWidget(
                  photo: Photo(),
                );
              },
            ),
          ) // 갯수가 정해져있으면 count/ 동적이면 builder
        ],
      ),
    );
  }
}