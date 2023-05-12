import 'package:flutter/material.dart';
import 'package:image_storage/data/pixabay_api.dart';
import 'package:image_storage/data/photo_provider.dart';
import 'package:image_storage/ui/home_screen.dart';
import 'package:image_storage/ui/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoProvider(
        viewModel: HomeViewModel(PixabayApi()),
        //api: PixabayApi(), // 이 부분 photo_provider 생성자 강의와 다르게 자동생성하면 에러남
        child: const HomeScreen(),
      ),
    );
  }
}
