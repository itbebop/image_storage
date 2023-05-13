import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_storage/data/photo_provider.dart';
import 'package:image_storage/ui/widget/photo_widget.dart';
import 'package:http/http.dart' as http;
import '../data/pixabay_api.dart';
import '../model/photo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = PhotoProvider.of(context).viewModel;

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
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    viewModel.fetch(_controller.text);
                    // final photos = await photoProvider.api.fetch(_controller.text);
                    // setState(() {
                    //   _photos = photos;
                    // });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          StreamBuilder<List<Photo>>(
              stream: viewModel.photoStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final photos = snapshot.data!;

                return Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(
                        16.0), // GridView는 padding 속성 갖고 있어서 직접 줌
                    //shrinkWrap: true,
                    itemCount: photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final photo = photos[index];
                      return PhotoWidget(
                        photo: photo,
                      );
                    },
                  ),
                );
              }) // 갯수가 정해져있으면 count/ 동적이면 builder
        ],
      ),
    );
  }
}
